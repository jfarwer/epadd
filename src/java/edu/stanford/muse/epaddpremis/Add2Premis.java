/*
  Servlet to add PREMIS event manally
*/
package edu.stanford.muse.epaddpremis;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.JSONObject;
import edu.stanford.muse.index.Archive;
import edu.stanford.muse.index.ArchiveReaderWriter;
import edu.stanford.muse.util.Util;
import edu.stanford.muse.webapp.JSPHelper;
import java.time.format.DateTimeFormatter;
import java.time.ZonedDateTime;
import java.time.LocalDateTime;
import java.time.ZoneId;

@WebServlet(name = "Add2Premis", urlPatterns = {"/ajax/add2Premis"})
public class Add2Premis extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        JSONObject json = new JSONObject(); 
        String jsonResult="failed", jsonReason="";

        String archiveID = request.getParameter("archive");
        EpaddEvent.EventType premisevent = EpaddEvent.EventType.fromString (request.getParameter("premisevent"));
        String premisdetail = request.getParameter("premisdetail");
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");        
        LocalDateTime date1 = LocalDateTime.parse(request.getParameter("premisdatetime"), formatter);
        ZonedDateTime zdatetime = date1.atZone(ZoneId.systemDefault());
        try {
                Archive archive = ArchiveReaderWriter.getArchiveForArchiveID(archiveID);  
                if (archive!=null) {
                    EpaddPremis epaddPremis = archive.getEpaddPremis();
                    if (epaddPremis!=null) {
                        epaddPremis.createEvent(premisevent, premisdetail, "", zdatetime);
                        jsonResult = "ok";
                        jsonReason = "PREMIS metadata is updated";
                    } else {
                        jsonReason = "Error in writing PREMIS data";
                    }
                } else {
                    jsonReason = "Archive not found";
                }
                
        } catch (Exception e1) {
                jsonReason = e1.getMessage();
        }

        json.put("result", jsonResult);
        json.put("reason", jsonReason);            
        
        try ( PrintWriter out = response.getWriter()) {
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            out.print(json.toString());
            out.flush();            
        } catch (Exception e) {
//            e.printStackTrace();
            Util.print_exception("Add2Premis", e, JSPHelper.log);
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Delete a folder";
    }// </editor-fold>

}
