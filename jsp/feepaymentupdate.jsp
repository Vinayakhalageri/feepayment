<%@ page import="java.util.*, com.model.FeePayment" %>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">

<title>Update Fee Payment</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">

<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">

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

/* MAIN BOX */

.container-box{

    background:rgba(255,255,255,0.97);

    border-radius:30px;

    padding:35px;

    max-width:950px;

    margin:auto;

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

/* TITLE */

.page-title{

    text-align:center;

    font-size:2.6rem;

    font-weight:800;

    color:#4f46e5;

    margin-bottom:10px;
}

.page-subtitle{

    text-align:center;

    color:#6b7280;

    margin-bottom:30px;
}

/* SEARCH BOX */

.search-box{

    background:
    linear-gradient(
    135deg,
    #eef2ff,
    #dbeafe);

    padding:25px;

    border-radius:20px;

    margin-bottom:30px;
}

/* PAYMENT CARD */

.payment-card{

    background:white;

    border-radius:20px;

    padding:20px;

    margin-bottom:20px;

    cursor:pointer;

    transition:0.3s;

    border-left:6px solid #4f46e5;

    box-shadow:
    0 5px 15px rgba(0,0,0,0.08);
}

.payment-card:hover{

    transform:translateY(-5px);

    background:#eef2ff;
}

/* FORM SECTION */

.edit-section{

    background:#f8fafc;

    border-radius:25px;

    padding:30px;

    margin-top:30px;

    box-shadow:
    0 5px 15px rgba(0,0,0,0.08);
}

/* LABELS */

.form-label{

    font-weight:700;

    color:#374151;
}

/* INPUTS */

.form-control,
.form-select{

    border-radius:12px;

    padding:12px;
}

.readonly-field{

    background:#e5e7eb;

    font-weight:bold;
}

/* BUTTONS */

.btn-custom{

    padding:12px;

    border:none;

    border-radius:15px;

    font-weight:700;

    transition:0.3s;
}

.btn-custom:hover{

    transform:translateY(-2px);
}

/* UPDATE BUTTON */

.update-btn{

    background:
    linear-gradient(
    135deg,
    #f59e0b,
    #d97706);

    color:white;
}

/* SEARCH BUTTON */

.search-btn{

    background:
    linear-gradient(
    135deg,
    #4f46e5,
    #7c3aed);

    color:white;
}

/* BADGES */

.status-paid{

    background:#16a34a;

    color:white;

    padding:8px 15px;

    border-radius:20px;

    font-size:13px;

    font-weight:700;
}

.status-overdue{

    background:#dc2626;

    color:white;

    padding:8px 15px;

    border-radius:20px;

    font-size:13px;

    font-weight:700;
}

/* RESPONSIVE */

@media(max-width:768px){

.page-title{

    font-size:2rem;
}

.container-box{

    padding:20px;
}

}

</style>

</head>

<body>

<div class="container">

<div class="container-box">

<!-- TITLE -->

<h1 class="page-title">

<i class="fas fa-edit me-2"></i>

Update Fee Payment

</h1>

<p class="page-subtitle">

Search student payment records and update details

</p>

<!-- MESSAGE -->

<%

if(request.getAttribute("message") != null){

%>

<div class="alert alert-<%= request.getAttribute("messageType") %> text-center">

<%= request.getAttribute("message") %>

</div>

<%

}

%>

<!-- SEARCH FORM -->

<div class="search-box">

<form method="post" action="updateFeePayment">

<input type="hidden" name="action" value="search">

<div class="row g-3 align-items-end">

<div class="col-md-9">

<label class="form-label">

<i class="fas fa-id-card me-2"></i>

Enter Student ID

</label>

<input type="number"
class="form-control"
name="studentId"

value="<%= request.getAttribute("searchedId") != null
? request.getAttribute("searchedId")
: "" %>"

placeholder="Enter Student ID"

required>

</div>

<div class="col-md-3">

<button type="submit"
class="btn btn-custom search-btn w-100">

<i class="fas fa-search me-2"></i>

Search

</button>

</div>

</div>

</form>

</div>

<!-- DISPLAY PAYMENT RECORDS -->

<%

if(request.getAttribute("payments") != null){

List<FeePayment> payments =
(List<FeePayment>) request.getAttribute("payments");

/* SORT PAYMENT IDS */

Collections.sort(
payments,
new Comparator<FeePayment>(){

    public int compare(FeePayment p1,
                       FeePayment p2){

        return Integer.compare(
            p1.getPaymentId(),
            p2.getPaymentId()
        );
    }

});

%>

<div class="mt-4">

<h4 class="mb-4">

<i class="fas fa-list me-2"></i>

Payment Records Found

</h4>

<%

for(FeePayment p : payments){

%>

<div class="payment-card"
onclick="editPayment(<%= p.getPaymentId() %>)">

<div class="row">

<div class="col-md-3">

<strong>Payment ID</strong>

<br>

<%= p.getPaymentId() %>

</div>

<div class="col-md-3">

<strong>Student ID</strong>

<br>

<%= p.getStudentId() %>

</div>

<div class="col-md-3">

<strong>Amount</strong>

<br>

Rs <%= p.getAmount() %>

</div>

<div class="col-md-3">

<strong>Status</strong>

<br><br>

<span class="<%= "Paid".equals(p.getStatus())
? "status-paid"
: "status-overdue" %>">

<%= p.getStatus() %>

</span>

</div>

</div>

<hr>

<div class="row">

<div class="col-md-6">

<strong>Student Name :</strong>

<%= p.getStudentName() %>

</div>

<div class="col-md-6">

<strong>Payment Date :</strong>

<%= p.getPaymentDate() %>

</div>

</div>

</div>

<%

}

%>

</div>

<%

}

%>

<!-- EDIT FORM -->

<%

if(request.getAttribute("editPayment") != null){

FeePayment p =
(FeePayment) request.getAttribute("editPayment");

%>

<div class="edit-section">

<h4 class="mb-4">

<i class="fas fa-pen me-2"></i>

Edit Payment Details

</h4>

<form method="post"
action="updateFeePayment">

<input type="hidden"
name="action"
value="update">

<input type="hidden"
name="paymentId"
value="<%= p.getPaymentId() %>">

<!-- PAYMENT ID -->

<div class="mb-3">

<label class="form-label">

Payment ID

</label>

<input type="text"
class="form-control readonly-field"
value="<%= p.getPaymentId() %>"
readonly>

</div>

<!-- STUDENT ID -->

<div class="mb-3">

<label class="form-label">

Student ID

</label>

<input type="text"
class="form-control readonly-field"
value="<%= p.getStudentId() %>"
readonly>

</div>

<!-- NAME -->

<div class="mb-3">

<label class="form-label">

Student Name

</label>

<input type="text"
class="form-control"
name="studentName"
value="<%= p.getStudentName() %>"
required>

</div>

<!-- DATE -->

<div class="mb-3">

<label class="form-label">

Payment Date

</label>

<input type="date"
class="form-control"
name="paymentDate"
value="<%= p.getPaymentDate() %>"
required>

</div>

<!-- AMOUNT -->

<div class="mb-3">

<label class="form-label">

Amount (Rs)

</label>

<input type="number"
step="0.01"
class="form-control"
name="amount"
value="<%= p.getAmount() %>"
required>

</div>

<!-- STATUS -->

<div class="mb-4">

<label class="form-label">

Status

</label>

<select class="form-select"
name="status">

<option value="Paid"
<%= p.getStatus().equals("Paid")
? "selected"
: "" %>>

Paid

</option>

<option value="Overdue"
<%= p.getStatus().equals("Overdue")
? "selected"
: "" %>>

Overdue

</option>

</select>

</div>

<button type="submit"
class="btn btn-custom update-btn w-100">

<i class="fas fa-save me-2"></i>

Update Payment

</button>

</form>

</div>

<%

}

%>

<!-- HOME BUTTON -->

<div class="text-center mt-4">

<a href="index.jsp"
class="btn btn-secondary px-4 py-2">

<i class="fas fa-home me-2"></i>

Back To Home

</a>

</div>

</div>

</div>

<!-- SCRIPT -->

<script>

function editPayment(paymentId){

    var form =
    document.createElement('form');

    form.method = 'post';

    form.action = 'updateFeePayment';

    var actionInput =
    document.createElement('input');

    actionInput.type = 'hidden';

    actionInput.name = 'action';

    actionInput.value = 'edit';

    var idInput =
    document.createElement('input');

    idInput.type = 'hidden';

    idInput.name = 'paymentId';

    idInput.value = paymentId;

    form.appendChild(actionInput);

    form.appendChild(idInput);

    document.body.appendChild(form);

    form.submit();
}

</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>