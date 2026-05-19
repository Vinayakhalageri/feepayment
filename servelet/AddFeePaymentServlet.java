package com.servlet;

import com.dao.FeePaymentDAO;
import com.model.FeePayment;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Date;
import java.time.LocalDate;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/addFeePayment")
public class AddFeePaymentServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private FeePaymentDAO dao;

    @Override
    public void init() {
        dao = new FeePaymentDAO();
    }

    // LOAD FORM
    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        loadNextIds(request);

        request.getRequestDispatcher("feepaymentadd.jsp")
               .forward(request, response);
    }

    // SAVE PAYMENT
    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        try {

            int studentId =
                    Integer.parseInt(request.getParameter("studentId"));

            String studentName =
                    request.getParameter("studentName");

            String paymentDate =
                    request.getParameter("paymentDate");

            BigDecimal amount =
                    new BigDecimal(request.getParameter("amount"));

            String status =
                    request.getParameter("status");

            // VALIDATION
            if (studentName == null ||
                studentName.trim().isEmpty()) {

                throw new Exception("Student name is required");
            }

            if (amount.compareTo(BigDecimal.ZERO) <= 0) {
                throw new Exception("Amount must be greater than zero");
            }

            // CREATE OBJECT
            FeePayment payment = new FeePayment();

            payment.setStudentId(studentId);
            payment.setStudentName(studentName);
            payment.setPaymentDate(Date.valueOf(paymentDate));
            payment.setAmount(amount);
            payment.setStatus(status);

            // SAVE
            FeePayment savedPayment =
                    dao.addFeePayment(payment);

            if (savedPayment != null) {

                request.setAttribute(
                        "message",
                        "Payment Added Successfully");

                request.setAttribute(
                        "messageType",
                        "success");

                request.setAttribute(
                        "savedPayment",
                        savedPayment);

            } else {

                request.setAttribute(
                        "message",
                        "Failed to Add Payment");

                request.setAttribute(
                        "messageType",
                        "danger");
            }

        } catch (Exception e) {

            e.printStackTrace();

            request.setAttribute(
                    "message",
                    e.getMessage());

            request.setAttribute(
                    "messageType",
                    "danger");
        }

        // VERY IMPORTANT
        // FETCH UPDATED IDs AGAIN FROM DATABASE

        loadNextIds(request);

        request.getRequestDispatcher("feepaymentadd.jsp")
               .forward(request, response);
    }

    // COMMON METHOD
    private void loadNextIds(HttpServletRequest request) {

        int nextPaymentId = dao.getNextPaymentId();

        int nextStudentId = dao.getNextStudentId();

        request.setAttribute(
                "nextPaymentId",
                nextPaymentId);

        request.setAttribute(
                "nextStudentId",
                nextStudentId);

        request.setAttribute(
                "currentDate",
                LocalDate.now().toString());

        System.out.println("SERVLET RUNNING");
        System.out.println("NEXT PAYMENT ID = " + nextPaymentId);
        System.out.println("NEXT STUDENT ID = " + nextStudentId);
    }
}