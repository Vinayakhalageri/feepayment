<%@ page import="java.util.*, java.math.BigDecimal, com.model.FeePayment" %>

<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="UTF-8">

<meta name="viewport"
content="width=device-width, initial-scale=1.0">

<title>Report Result</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
rel="stylesheet">

<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"
rel="stylesheet">

<style>

*{
    margin:0;
    padding:0;
    box-sizing:border-box;
}

body{

    background:
    linear-gradient(
    135deg,
    #4f46e5 0%,
    #7c3aed 50%,
    #2563eb 100%);

    min-height:100vh;

    padding:40px 15px;

    font-family:'Segoe UI',sans-serif;
}

/* MAIN CONTAINER */

.result-container{

    background:
    rgba(255,255,255,0.97);

    border-radius:30px;

    padding:35px;

    box-shadow:
    0 15px 40px rgba(0,0,0,0.25);

    animation:fadeIn 0.8s ease;
}

/* ANIMATION */

@keyframes fadeIn{

from{
    opacity:0;
    transform:translateY(30px);
}

to{
    opacity:1;
    transform:translateY(0);
}

}

/* HEADER */

.report-header{

    background:
    linear-gradient(
    135deg,
    #4f46e5,
    #7c3aed);

    color:white;

    border-radius:25px;

    padding:30px;

    margin-bottom:30px;

    text-align:center;
}

.report-header h1{

    font-size:2.5rem;

    font-weight:800;

    margin-bottom:10px;
}

.report-header p{

    opacity:0.9;
}

/* SUMMARY */

.summary-card{

    background:
    linear-gradient(
    135deg,
    #eef2ff,
    #dbeafe);

    border-radius:20px;

    padding:25px;

    text-align:center;

    margin-bottom:20px;

    transition:0.3s;

    box-shadow:
    0 5px 15px rgba(0,0,0,0.08);
}

.summary-card:hover{

    transform:translateY(-5px);
}

.summary-title{

    color:#6b7280;

    margin-bottom:10px;

    font-weight:600;
}

.summary-value{

    font-size:30px;

    font-weight:800;

    color:#4f46e5;
}

/* TABLE */

.table{

    border-radius:20px;

    overflow:hidden;
}

.table thead{

    background:
    linear-gradient(
    135deg,
    #4f46e5,
    #7c3aed);

    color:white;
}

.table thead th{

    padding:16px;

    border:none;

    text-align:center;
}

.table tbody tr{

    transition:0.3s;
}

.table tbody tr:hover{

    background:#eef2ff;

    transform:scale(1.01);
}

.table tbody td{

    padding:14px;

    text-align:center;

    vertical-align:middle;

    font-weight:500;
}

/* STATUS */

.status-paid{

    background:#16a34a;

    color:white;

    padding:8px 15px;

    border-radius:30px;

    font-size:13px;

    font-weight:700;
}

.status-overdue{

    background:#dc2626;

    color:white;

    padding:8px 15px;

    border-radius:30px;

    font-size:13px;

    font-weight:700;
}

/* BUTTONS */

.action-btn{

    padding:12px 24px;

    border:none;

    border-radius:15px;

    font-weight:700;

    transition:0.3s;
}

.action-btn:hover{

    transform:translateY(-2px);
}

.print-btn{

    background:#6b7280;

    color:white;
}

.back-btn{

    background:
    linear-gradient(
    135deg,
    #4f46e5,
    #7c3aed);

    color:white;
}

/* EMPTY */

.empty-box{

    padding:40px;

    text-align:center;

    color:#6b7280;
}

/* PRINT */

@media print{

body{

    background:white;

    padding:0;
}

.no-print{

    display:none;
}

.result-container{

    box-shadow:none;
}

}

/* RESPONSIVE */

@media(max-width:768px){

.report-header h1{

    font-size:2rem;
}

.result-container{

    padding:20px;
}

.table thead th,
.table tbody td{

    font-size:13px;

    padding:10px;
}

}

</style>

</head>

<body>

<div class="container">

<div class="result-container">

<!-- HEADER -->

<div class="report-header">

<h1>

<i class="fas fa-chart-line me-2"></i>

<%= request.getAttribute("reportTitle") %>

</h1>

<p>

<i class="fas fa-calendar-alt me-2"></i>

Generated On :

<%= new java.text.SimpleDateFormat(
"dd-MM-yyyy HH:mm:ss")
.format(new java.util.Date()) %>

</p>

</div>

<!-- SUMMARY -->

<div class="row mb-4">

<div class="col-md-4">

<div class="summary-card">

<div class="summary-title">

Total Records

</div>

<div class="summary-value">

<%= request.getAttribute("recordCount") != null
? request.getAttribute("recordCount")
: "0" %>

</div>

</div>

</div>

<%

if(request.getAttribute("totalAmount") != null){

%>

<div class="col-md-4">

<div class="summary-card">

<div class="summary-title">

Total Amount

</div>

<div class="summary-value text-success">

Rs <%= String.format(
"%,.2f",
((BigDecimal)
request.getAttribute("totalAmount"))) %>

</div>

</div>

</div>

<%

}

%>

<%

if(request.getAttribute("totalCollection") != null){

%>

<div class="col-md-4">

<div class="summary-card">

<div class="summary-title">

Total Collection

</div>

<div class="summary-value text-success">

Rs <%= String.format(
"%,.2f",
((BigDecimal)
request.getAttribute("totalCollection"))) %>

</div>

</div>

</div>

<%

}

%>

</div>

<!-- DATE RANGE -->

<%

if(request.getAttribute("startDate") != null){

%>

<div class="alert alert-primary rounded-4 mb-4">

<i class="fas fa-calendar-check me-2"></i>

<strong>Date Range :</strong>

<%= request.getAttribute("startDate") %>

to

<%= request.getAttribute("endDate") %>

</div>

<%

}

%>

<!-- TABLE -->

<div class="table-responsive">

<table class="table table-hover align-middle">

<thead>

<tr>

<th>Payment ID</th>

<th>Student ID</th>

<th>Student Name</th>

<th>Payment Date</th>

<%

if(request.getAttribute("showAmount") != null
&& (Boolean)
request.getAttribute("showAmount")){

%>

<th>Amount (Rs)</th>

<%

}

%>

<th>Status</th>

</tr>

</thead>

<tbody>

<%

List<FeePayment> reportData =
(List<FeePayment>)
request.getAttribute("reportData");

if(reportData != null
&& !reportData.isEmpty()){

Collections.sort(
reportData,
new Comparator<FeePayment>(){

public int compare(
FeePayment p1,
FeePayment p2){

return Integer.compare(
p1.getPaymentId(),
p2.getPaymentId());

}

});

for(FeePayment payment : reportData){

%>

<tr>

<td>

<strong>

<%= payment.getPaymentId() %>

</strong>

</td>

<td>

<%= payment.getStudentId() %>

</td>

<td>

<%= payment.getStudentName() %>

</td>

<td>

<%= payment.getPaymentDate() %>

</td>

<%

if(request.getAttribute("showAmount") != null
&& (Boolean)
request.getAttribute("showAmount")){

%>

<td>

<strong>

Rs <%= String.format(
"%,.2f",
payment.getAmount()) %>

</strong>

</td>

<%

}

%>

<td>

<span class="<%= payment.getStatus().equals("Paid")
? "status-paid"
: "status-overdue" %>">

<%= payment.getStatus() %>

</span>

</td>

</tr>

<%

}

}else{

%>

<tr>

<td colspan="<%= (request.getAttribute("showAmount") != null
&& (Boolean)
request.getAttribute("showAmount"))
? 6 : 5 %>">

<div class="empty-box">

<i class="fas fa-inbox fa-3x mb-3"></i>

<h5>

No Records Found

</h5>

<p>

No payment records available for this report

</p>

</div>

</td>

</tr>

<%

}

%>

</tbody>

<%

if(reportData != null
&& !reportData.isEmpty()
&& request.getAttribute("totalCollection") != null){

%>

<tfoot class="table-secondary">

<tr>

<th colspan="4"
class="text-end">

Total Collection :

</th>

<th>

Rs <%= String.format(
"%,.2f",
(BigDecimal)
request.getAttribute(
"totalCollection")) %>

</th>

<th></th>

</tr>

</tfoot>

<%

}

%>

</table>

</div>

<!-- BUTTONS -->

<div class="text-center mt-4 no-print">

<button onclick="window.print()"
class="btn action-btn print-btn me-2">

<i class="fas fa-print me-2"></i>

Print Report

</button>

<button onclick="window.location.href='report_form.jsp'"
class="btn action-btn back-btn">

<i class="fas fa-arrow-left me-2"></i>

Back To Reports

</button>

</div>

</div>

</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>

</body>

</html>