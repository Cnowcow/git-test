<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="evaluation.EvaluationDAO" %>
<%@ page import="evaluation.EvaluationDTO" %>
<%@ page import="util.SHA256" %>
<%@ page import="java.io.PrintWriter" %>
<%
    request.setCharacterEncoding("UTF-8");
	String userID = null;
	if(session.getAttribute("userID") != null){
		userID = (String) session.getAttribute("userID");
	}
	if(userID == null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
	    script.println("alert('로그인이 필요합니다')");
		script.println("location.href = 'userLogin.jsp'");
		script.println("</script>");
		script.close();
		return;
	}
	
	String lectureName = null;
	String professorName = null;
	int lectureYear = 0;
	String semesterDivide = null;
	String lectureDivide = null;
	String evaluationTitle = null;
	String evaluationContent = null;
	String totalScore = null;
	String creditScore = null;
	String comfortableScore = null;
	String lectureScroe = null;
	
	

    // 사용자로부터 입력 받은 값들을 변수에 할당
    if(request.getParameter("lectureName") != null){
    	lectureName = request.getParameter("lectureName");
    }
    if(request.getParameter("professorName") != null){
    	professorName = request.getParameter("professorName");
    }
    if(request.getParameter("lectureYear") != null){
       try{
    	   lectureYear = Integer.parseInt(request.getParameter("lectureYear"));
       }catch(Exception e){
    	   System.out.println("강의 연도 데이터 오류");
       }
    }
    if(request.getParameter("semesterDivide") != null){
    	semesterDivide = request.getParameter("semesterDivide");
    }
    if(request.getParameter("lectureDivide") != null){
    	lectureDivide = request.getParameter("lectureDivide");
    }
    if(request.getParameter("evaluationTitle") != null){
    	evaluationTitle = request.getParameter("evaluationTitle");
    }
    if(request.getParameter("evaluationContent") != null){
    	evaluationContent = request.getParameter("evaluationContent");
    }
    if(request.getParameter("totalScore") != null){
    	totalScore = request.getParameter("totalScore");
    }
    if(request.getParameter("creditScore") != null){
    	creditScore = request.getParameter("creditScore");
    }
    if(request.getParameter("comfortableScore") != null){
    	comfortableScore = request.getParameter("comfortableScore");
    }
    if(request.getParameter("lectureScroe") != null){
    	lectureScroe = request.getParameter("lectureScroe");
    }

    // 입력 값이 null이면 오류 처리
    if(lectureName == null || professorName == null || lectureYear == 0 || semesterDivide == null || lectureDivide == null || evaluationTitle == null ||
    		evaluationContent == null || totalScore == null || creditScore == null || comfortableScore == null || lectureScroe == null || 
       evaluationTitle.equals("") || evaluationContent.equals("")){
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('입력되지 않은 사항이 있습니다.')");
        script.println("history.back();");
        script.println("</script>");
        script.close();
        return;
    } 
   
	EvaluationDAO evaluationDAO = new EvaluationDAO();
	int result = evaluationDAO.write(new EvaluationDTO(0, userID, lectureName, professorName, lectureYear, semesterDivide, lectureDivide, evaluationTitle,
			evaluationContent, totalScore, creditScore, comfortableScore, lectureScroe, 0));

	if (result == -1){
	// 이미 존재하는 아이디인 경우
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('강의평가 등록에 실패했습니다.')");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;
	} else {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("location.href = 'index.jsp'");
		script.println("</script>");
		script.close();
		return;
	}
    
%>