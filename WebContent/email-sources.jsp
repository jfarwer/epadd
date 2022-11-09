<%@page contentType="text/html; charset=UTF-8"%>
<%@page trimDirectiveWhitespaces="true"%>
<%@page language="java" import="edu.stanford.muse.AddressBookManager.AddressBook"%>
<%@page language="java" import="edu.stanford.muse.index.Archive"%>
<%@page language="java" import="java.util.Set"%>
<%@ page import="edu.stanford.muse.webapp.ModeConfig" %>
<%@page language="java" %>

<%--
	<%@ page import="Internationalisation.ReadFromProp"%>
--%>
<%
/*    
    2022-11-09  Added Sidecar file listing
*/    
%>

<!DOCTYPE HTML>
<html>


<head>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="icon" type="image/png" href="images/epadd-favicon.png">


	<link rel="stylesheet" href="bootstrap/dist/css/bootstrap.min.css">
	<link href="jqueryFileTree/jqueryFileTree.css" rel="stylesheet" type="text/css" media="screen" />
	<jsp:include page="css/css.jsp"/>
	<link rel="stylesheet" href="css/sidebar.css">
    <link rel="stylesheet" href="css/main.css">

    <style>
		.div-input-field { display: inline-block; width: 400px; margin-left: 20px; line-height:10px; padding:20px; vertical-align: top;}
		.input-field {width:350px;}
		.input-field-label {font-size: 12px;}

	</style>

	<script src="js/jquery.js"></script>
	<script type="text/javascript" src="bootstrap/dist/js/bootstrap.min.js"></script>
	<script src="jqueryFileTree/jqueryFileTree.js"></script>
	<script src="js/filepicker.js"></script>
	<script src="js/modernizr.min.js"></script>
	<script src="js/sidebar.js"></script>

	<script src="js/muse.js"></script>
	<script src="js/epadd.js"></script>

</head>
<body style="background-color:white;">


<%-- header.jspf was here --%>
<%@include file="header.jspf" %>
<title><%=edu.stanford.muse.util.Messages.getMessage(archiveID, "messages", "appraisal.email-sources.head-specify-source")%></title>

<jsp:include page="div_filepicker.jspf"/>

<% if (ModeConfig.isAppraisalMode()) { %>
	<script>epadd.nav_mark_active('Import');</script>
<% } else { %>
	<script>epadd.nav_mark_active('New');</script>
<% } %>

<div class="nav-toggle1 sidebar-icon">
    <img src="images/sidebar.png" alt="sidebar">
</div>

<!--sidebar content-->
<nav class="menu1" role="navigation">
	<h2><%=edu.stanford.muse.util.Messages.getMessage(archiveID, "help", "email-sources.help.head")%></h2>

	<!--close button-->
    <a class="nav-toggle1 show-nav1" href="#">
        <img src="images/close.png" class="close" alt="close">
    </a>

    <!--phrase-->
    <div class="search-tips">
		<%=edu.stanford.muse.util.Messages.getMessage(archiveID, "help", "email-sources.help.import-info")%>
	</div>
</nav>
<%
	//Term t;
	//initialization of JPL -- just for Testing
	//JPL.init();
	//load model file..
Archive archive =  JSPHelper.getArchive(request);
String bestName = "";
String bestEmail = "";
if (archive != null) {
	AddressBook ab = archive.addressBook;
	Set<String> addrs = ab.getOwnAddrs();
	if (addrs.size() > 0)
		bestEmail = addrs.iterator().next();
	writeProfileBlock(out, archive, "Import email into this archive");
}
%>

<p>

<form method="post" class="form-horizontal">
<div id="all_fields" style="margin-left:170px; width:900px; padding: 10px">
	<section>
		<div class="panel">
			<div class="panel-heading"><%=edu.stanford.muse.util.Messages.getMessage(archiveID, "messages", "appraisal.email-sources.about-archive")%> </div>
			<div class="div-input-field">
				<div class="input-field-label"><i class="fa fa-user"></i><%=edu.stanford.muse.util.Messages.getMessage(archiveID, "messages", "appraisal.email-sources.owner-name")%> </div>
				<br/>
				<div class="input-field">
					<input title="Name of archive owner" class="form-control" type="text" name="name" value="<%=bestName%>"/>
				</div>
			</div>
			<div class="div-input-field">
				<div class="input-field-label"><i class="fa fa-envelope"></i> <%=edu.stanford.muse.util.Messages.getMessage(archiveID, "messages", "appraisal.email-sources.p-email")%></div>
				<br/>
				<div class="input-field">
					<input class="form-control" type="text" name="alternateEmailAddrs" value="<%=bestEmail%>"/>
				</div>
			</div>

			<div class="div-input-field">
				<div class="input-field-label"><i class="fa fa-tag"></i> <%=edu.stanford.muse.util.Messages.getMessage(archiveID, "messages", "appraisal.email-sources.archive-title")%></div>
				<br/>
				<div class="input-field">
					<input class="form-control" type="text" name="archiveTitle" value=""/>
				</div>
			</div>

		</div>
	</section>

	<section>
	<div id="servers" class="accounts panel">
		<% /* proper field names and ids will be assigned later, when the form is actually submitted */ %>
		<div class="panel-heading"><%=edu.stanford.muse.util.Messages.getMessage(archiveID, "messages", "appraisal.email-sources.public-imap")%></div>

		<div class="account">
			<input class="accountType" type="text" style="display:none" id="accountType0" name="accountType0" value="email"/>

			<div class="div-input-field">
				<div class="input-field-label"><i class="fa fa-envelope"></i><%=edu.stanford.muse.util.Messages.getMessage(archiveID, "messages", "appraisal.email-sources.public-imap-email")%></div>
				<br/>
				<div class="input-field"><input class="form-control" type="text" name="loginName0"/></div>
			</div>

			<div class="div-input-field">
				<div class="input-field-label"><i class="fa fa-key"></i> <%=edu.stanford.muse.util.Messages.getMessage(archiveID, "messages", "appraisal.email-sources.public-imap-pass")%><img class="spinner" id="spinner0" src="images/spinner3-black.gif" width="15" style="margin-left:10px;visibility:hidden"></div>
				<br/>
				<div class="input-field"><input class="form-control" type="password" name="password0"/></div>
			</div>
			<br/>
		</div>
		<br/>

		<button style="margin-left:40px" class="btn-default" onclick="add_server(); return false;"><i class="fa fa-plus"></i> <%=edu.stanford.muse.util.Messages.getMessage(archiveID, "messages", "appraisal.email-sources.another-public-imap")%></button>
		<br/>
		<br/>
	</div> <!--  end servers -->
</section>

	<section>
	<div id="private_servers" class="accounts panel">
		<div class="panel-heading">
			<%=edu.stanford.muse.util.Messages.getMessage(archiveID, "messages", "appraisal.email-sources.private-imap")%><br/>
		</div>
		<p></p>

		<% /* proper field names and ids will be assigned later, when the form is actually submitted */ %>
		<div class="account">
			<input class="accountType" type="text" style="display:none" id="accountType1" name="accountType1" value="email"/>

			<div class="div-input-field">
				<div class="input-field-label"><i class="fa fa-server"></i><%=edu.stanford.muse.util.Messages.getMessage(archiveID, "messages", "appraisal.email-sources.private-imap-server")%></div>
				<br/>
				<div class="input-field"><input class="form-control" type="text" name="server1"/></div>
			</div>
			<br/>

			<div class="div-input-field">
				<div class="input-field-label"><i class="fa fa-envelope"></i><%=edu.stanford.muse.util.Messages.getMessage(archiveID, "messages", "appraisal.email-sources.private-imap-email")%></div>
				<br/>
				<div class="input-field"><input class="form-control" type="text" name="loginName1"/></div>
			</div>

			<div class="div-input-field">
				<div class="input-field-label"><i class="fa fa-key"></i><%=edu.stanford.muse.util.Messages.getMessage(archiveID, "messages", "appraisal.email-sources.private-imap-pass")%> <img class="spinner" id="spinner1" src="images/spinner3-black.gif" width="15" style="margin-left:10px;visibility:hidden"><br/>
				</div>
				<br/>
				<div class="input-field"><input class="form-control" type="password" name="password1"/></div>
			</div>
			<br/>

		</div>
		<br/>
		<button style="margin-left:40px" class="btn-default" onclick="add_private_server(); return false;"><i class="fa fa-plus"></i> <%=edu.stanford.muse.util.Messages.getMessage(archiveID, "messages", "appraisal.email-sources.another-private-imap")%></button>
		<br/>
		<br/>

	</div> <!--  end servers -->
</section>


	<section>
		<div id="mboxes" class="accounts panel">
			<div class="panel-heading">
				<%=edu.stanford.muse.util.Messages.getMessage(archiveID, "messages", "appraisal.email-sources.mbox-file")%><br/>
			</div>

			<% /* all mboxes folders will be in account divs here */ %>
			<div class="account">
				<input class="accountType" type="text" style="display:none" name="accountType2" value="mbox"/>
				<div class="div-input-field">
					<div class="input-field-label"><i class="fa fa-folder-o"></i> <%=edu.stanford.muse.util.Messages.getMessage(archiveID, "messages", "appraisal.email-sources.f-location")%></div>
					<br/>
					<div class="input-field" style="width:800px"> <!-- override default 350px width because we need a wider field and need browse button on side-->
                        <div class="form-group col-sm-8">
    						<input class="dir form-control" type="text" name="mboxDir2"/> <br/>
                        </div>
                        <div class="form-group col-sm-4">
                            <button style="height:37px" class="browse-button btn-default"><i class="fa fa-file"></i> <!-- special height for this button to make it align perfectly with input box. same height is used in export page as well -->
                                <span><%=edu.stanford.muse.util.Messages.getMessage(archiveID, "messages", "appraisal.email-sources.browse")%></span>
                            </button>
                        </div>
					</div>
					<br/>
				</div>
				<div class="div-input-field">
					<div class="input-field-label"><i class="fa fa-bullseye"></i><%=edu.stanford.muse.util.Messages.getMessage(archiveID, "messages", "appraisal.email-sources.source-name")%></div>
					<br/>
					<div class="input-field">
						<input class="form-control" type="text" name="emailSource2" value=""/>
					</div>
				</div>

				<br/>
			</div> <!--  end account -->
			<br/>
			<button  style="margin-left:40px" class="btn-default" onclick="return add_mboxdir(); return false;"><i class="fa fa-plus"></i><%=edu.stanford.muse.util.Messages.getMessage(archiveID, "messages", "appraisal.email-sources.add-folder")%></button>
			<br/>
			<br/>
		</div>
	</section>
<section>

	<div id="sidecarfile_upload" class="accounts panel">
		<%--Button for starting sidecar upload--%>
		<div class="panel-heading">
			<% if (archiveID == null) { %>
			<div title="<%=edu.stanford.muse.util.Messages.getMessage(archiveID, "messages", "sidecar-top.upload-sidecar-no-archive")%>"
				 class="buttons_on_datatable"><img class="button_image" src="images/upload_red.svg">
			<%} else {%>
				<div title="<%=edu.stanford.muse.util.Messages.getMessage(archiveID, "messages", "sidecar-top.upload-sidecar")%>"
					 class="buttons_on_datatable" id="import-sidecar"><img class="button_image" src="images/upload.svg">
			<% } %>
				</div>
				<%=edu.stanford.muse.util.Messages.getMessage(archiveID, "messages", "appraisal.email-sources.sidecar")%>
				<br/>
			</div>
			<p></p>
			
            <% if (archiveID != null) { %>
                <button id="manage-sidecar-btn" class="btn-default" onclick="return goSidecarFiles();"><i class="fa fa-files-o fa-2x" aria-hidden="true"></i>&nbsp; 
                <%=edu.stanford.muse.util.Messages.getMessage(archiveID, "messages", "sidecar.management-title")%>
                </button>
            <% } %>                            
		</div>
<div>
</form>
		<%--Box for selecting an upload sidecar file		--%>
		<div id="sidecar-upload-modal" class="info-modal modal fade" style="z-index:99999">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
						<h4 class="modal-title"><%=edu.stanford.muse.util.Messages.getMessage(archiveID, "messages", "sidecar.upload.sidecar-file")%>
						</h4>
					</div>
					<div class="modal-body">
						<form id="uploadsidecarform" method="POST" enctype="multipart/form-data">
							<input type="hidden" value="<%=archiveID%>" name="archiveID"/>
							<div class="form-group **text-left**">
								<label for="sidecarfile"
									   class="col-sm-2 control-label **text-left**"><%=edu.stanford.muse.util.Messages.getMessage(archiveID, "messages", "correspondents.upload.file")%>
								</label>
								<div class="col-sm-10">
									<input type="file" id="sidecarfile" name="sidecarfile" value=""/>
	</div>
							</div>
						</form>
					</div>
					<div class="modal-footer">
						<button id="upload-sidecar-btn" class="btn btn-cta"
								onclick="uploadSidecarHandler();return false;"><%=edu.stanford.muse.util.Messages.getMessage(archiveID, "messages", "sidecar.upload.upload-button")%>
							<i class="icon-arrowbutton"></i></button>


						<%--<button id='overwrite-button' type="button" class="btn btn-default" data-dismiss="modal">Overwrite</button>--%>
						<%--<button id='cancel-button' type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>--%>
					</div>
				</div><!-- /.modal-content -->
			</div><!-- /.modal-dialog -->
		</div>
	</div>
	</div>
</section>



	<div style="text-align:center;margin-top:20px">
		<button class="btn btn-cta" id="gobutton" onclick="epadd.do_logins(); return false"> <%=edu.stanford.muse.util.Messages.getMessage(archiveID, "messages", "appraisal.email-sources.next")%> <i class="icon-arrowbutton"></i> </button>
	</div>
</div> <!--  all fields -->


</form>

<p>
<jsp:include page="footer.jsp"/>

	<script>
// 2022-11-09            
        function goSidecarFiles() {
            url = "sidecarFiles?archiveID=<%=archiveID%>";
            window.location.href = url;
            return false;
        }
	
		var uploadSidecarHandler=function() {
			var sidecarfilenameWithFakepath = $('#sidecarfile').val();
			debugger
			if (!sidecarfilenameWithFakepath) {
				alert('Please provide the path of the sidecar file');
				return false;
			}
			var form = $('#uploadsidecarform')[0];

			// Create an FormData object
			var data = new FormData(form);
			data.append('sidecarpath', sidecarfilenameWithFakepath);


			//hide the modal.
			$('#sidecar-upload-modal').modal('hide');
			//now send to the backend.. on it's success reload the same page. On failure display the error message.
			$.ajax({
				type: 'POST',
				enctype: 'multipart/form-data',
				processData: false,
				url: "ajax/upload-sidecarfile.jsp",
				contentType: false,
				cache: false,
				data: data,
				success: function () {
					epadd.success('Sidecar file uploaded.', function () {
						window.location.reload();
					});
				},
				error: function (jq, textStatus, errorThrown) {
					epadd.error("Error uploading file, status = " + textStatus + ' json = ' + jq.responseText + ' errorThrown = ' + errorThrown);
				}
			});
		}



		function add_server() {
			// clone the first account
			var $logins = $('#servers .account');
			var $clone = $($logins[0]).clone();
			$clone.insertAfter($logins[$logins.length-1]);
			$('input', $clone).val(''); // clear the fields so we don't carry over what the cloned fields had
			epadd.fix_login_account_numbers();
		}

		function add_private_server() {
			// clone the first account
			var $logins = $('#private_servers .account');
			var $clone = $($logins[0]).clone();
			$clone.insertAfter($logins[$logins.length-1]);
			$('input', $clone).val(''); // clear the fields so we don't carry over what the cloned fields had
			$('<br/>').insertAfter($logins[$logins.length-1]);
			epadd.fix_login_account_numbers();
		}
		var fps = []; // array of file pickers, could have multiple open at the same time, in theory.
		var $account0 = $($('#mboxes .account')[0]);
		fps.push(new FilePicker($account0));

		function add_mboxdir() {
			// first close all accounts, in case they have been expanded etc.
			for (var i = 0; i < fps.length; i++) {
				fps[i].close();
			}
			// clone the last account
			var $a = $('#mboxes .account');
			var $lasta = $($a[$a.length-1]);
			var $clone = $lasta.clone();
			$('input', $clone).val(''); // clear the fields so we don't carry over the values of the original fields
			$clone.insertAfter($lasta);
			$('<br/>').insertAfter($lasta);
            epadd.fix_login_account_numbers();

			fps.push(new FilePicker($clone));
			return false;
		}

		$(document).ready(function() {
			$('#import-sidecar').click(function(){
				//open modal box to get the sidecar file and upload
				$('#sidecar-upload-modal').modal('show');
			});

			$('input[type="text"]').each(function () {
				var field = 'email-source:' + $(this).attr('name');
				if (!field)
					return;
				var value = localStorage.getItem(field);
				$(this).val(value);
			});
		});

	</script>

</body>
</html>
