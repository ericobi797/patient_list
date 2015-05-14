<%@ include file="/WEB-INF/template/include.jsp"%>
<%@ include file="/WEB-INF/template/header.jsp"%>
<style type="text/css">
    .tg  {border-collapse:collapse;border-spacing:0;border-color:#ccc;}
    .tg td{font-family:Arial, sans-serif;font-size:14px;padding:10px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;border-color:#ccc;color:#333;background-color:#fff;}
    .tg th{font-family:Arial, sans-serif;font-size:14px;font-weight:normal;padding:10px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;border-color:#ccc;color:#333;background-color:#f0f0f0;}
    .tg .tg-4eph{background-color:#f9f9f9}
</style>
<openmrs:htmlInclude file="/moduleResources/healthassignment/jquery.dataTables.min.js"/>
<openmrs:htmlInclude file="/moduleResources/healthassignment/bootstrap.min.css"/>

<script type="text/javascript">
    $j(document).ready(function() {
        $j('#listp').dataTable({
            "bJQueryUI": true,
            "sPaginationType": "full_numbers"
        });
    } );
</script>

<div class="container">
<div class="panel panel-primary">
    <div class="panel-heading">
        <h3 class="panel-title"><b>List of Patients</b></h3>
    </div>
    <div class="panel-body" style="color: black;">
        <c:if test="${!empty listPatient}">
            <table id="listp" class="table table-striped" style="color: black;">
                <thead>
                <tr>
                    <th width="80">Patient ID</th>
                    <th width="150">Patient Name</th>
                    <th width="150">Age</th>
                    <th width="150">Gender</th>
                    <th width="150">Identifiers</th>
                    <th width="250">View Patient Summary</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${listPatient}" var="patient" varStatus="status">
                    <tr>
                        <td>${patient.patientId}</td>
                        <td>${patient.personName}</td>
                        <td>${patient.age}</td>
                        <td>${patient.gender}</td>
                        <td>${patient.identifiers}</td>
                        <td><a href="<c:url value='summary.form?id=${patient.patientId}' />" >Summary</a></td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </c:if>
    </div>
</div>
</div>
<%@ include file="/WEB-INF/template/footer.jsp"%>