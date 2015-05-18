<%@ include file="/WEB-INF/template/include.jsp"%>
<%@ include file="/WEB-INF/template/header.jsp"%>
<style type="text/css">
    .tg  {border-collapse:collapse;border-spacing:0;border-color:#ccc;}
    .tg td{font-family:Arial, sans-serif;font-size:14px;padding:10px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;border-color:#ccc;color:#333;background-color:#fff;}
    .tg th{font-family:Arial, sans-serif;font-size:14px;font-weight:normal;padding:10px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;border-color:#ccc;color:#333;background-color:#f0f0f0;}
    .tg .tg-4eph{background-color:#f9f9f9}
</style>
<openmrs:htmlInclude file="/moduleResources/healthassignment/jquery.dataTables.min.js" />
<openmrs:htmlInclude file="/moduleResources/healthassignment/bootstrap.min.css"/>

<script type="text/javascript">
    $j(document).ready(function() {
        $j('#summary').dataTable({
            "bJQueryUI": true,
            "sPaginationType": "full_numbers"
        });
    } );
</script>
<div class="container">

    <div class="panel panel-primary">
        <div class="panel-heading">
            <h3 class="panel-title">List of Patients</h3>
        </div>
        <div class="panel-body" style="color: black;">

<h3>Patient Details for: <i>${patientName.personName}</i></h3>

<table id="summary" class="table table-striped" style="color: black;">
    <thead>
    <tr>
        <th>Encounter Id</th>
        <th>Date </th>
        <th>Visit Type</th>
        <th>Location</th>
    </tr>
    </thead>
    <tbody>

    <c:forEach var="summary" items="${detail}" varStatus="status">
        <tr>
            <td>${summary.encounterType.name}</td>
            <td>${summary.encounterDatetime}</td>
            <td>${summary.visit.visitType.name}</td>
            <td>${summary.location}</td>
        </tr>
    </c:forEach>
    </tbody>
</table>
        </div>
    </div>
</div>

<%@ include file="/WEB-INF/template/footer.jsp"%>