<%@ include file="/WEB-INF/template/include.jsp"%>
<%@ include file="/WEB-INF/template/header.jsp"%>
<style type="text/css">
    .tg  {border-collapse:collapse;border-spacing:0;border-color:#ccc;}
    .tg td{font-family:Arial, sans-serif;font-size:14px;padding:10px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;border-color:#ccc;color:#333;background-color:#fff;}
    .tg th{font-family:Arial, sans-serif;font-size:14px;font-weight:normal;padding:10px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;border-color:#ccc;color:#333;background-color:#f0f0f0;}
    .tg .tg-4eph{background-color:#f9f9f9}
</style>
<head>
    <link rel="stylesheet" href="http://yui.yahooapis.com/pure/0.6.0/pure-min.css">
</head>
<openmrs:htmlInclude file="/moduleResources/healthassignment/jquery.dataTables.min.js"/>

<script type="text/javascript">
    $j(document).ready(function() {
        $j('#listp').dataTable({
            "bJQueryUI": true,
            "sPaginationType": "full_numbers"
        });
    } );
</script>

<div class="grid-wrapper">
    <div class="pure-g">
        <div class="pure-u-1-3">
            <p>Required fields are marked with an asterisk*</p>
            <form class="pure-form pure-form-stacked" action="<c:url value='create.form' />" method="post">
                <div class="pure-control-group">
                    <label for="fname">*First Name:</label>
                    <input type="text" name="fname" id="fname" required>
                </div>
                <div class="pure-control-group">
                    <label for="mname">*Middle Name:</label>
                    <input type="text" name="mname" id="mname" required>
                </div>
                <div class="pure-control-group">
                    <label for="lname">*Last Name:</label>
                    <input type="text" name="lname" id="lname" required>
                </div>
                <div class="pure-control-group">
                    <label for="age">*Age:</label>
                    <input type="number" name="age" id="age" required>
                </div>
                <div class="pure-control-group">
                    <label for="birthdate">*Birth Date:</label>
                    <input type="text" name="birthdate" id="birthdate" required>
                </div>
                <div class="pure-control-group">
                    <label >*Select gender:</label>
                    <input type="radio" name="sex" value="M" checked>Male
                    <input type="radio" name="sex" value="F">Female
                </div>
                <div class="pure-control-group">
                    <label for="country">*Country:</label>
                    <input type="text" name="country" id="country" required>
                </div>
                <div class="pure-control-group">
                    <label for="county">*County:</label>
                    <input type="text" name="county" id="county" required>
                </div>
                <div class="pure-control-group">
                    <label for="address">*Address:</label>
                    <input type="text" name="address" id="address" required>
                </div>
                <div class="pure-control-group">
                    <label for="pid">*ID number:</label>
                    <input type="number" name="pid" id="pid" required>
                </div>
                <div class="pure-control-group">
                    <button class="pure-button-primary">Save</button>
                </div>
            </form>
        </div>
        <div class="pure-u-1-2">
            <c:if test="${!empty listPatient}">
                <table id="listp" class="pure-table pure-table-bordered">
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


<%@ include file="/WEB-INF/template/footer.jsp"%>