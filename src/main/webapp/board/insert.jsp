<%@page import="java.net.URLEncoder"%>
<%@page import="dao.BoardDao"%>
<%@page import="vo.Customer"%>
<%@page import="vo.Board"%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%
	String title = request.getParameter("title");
	String content= request.getParameter("content");
	String loginId = (String) session.getAttribute("loginId");
	
	if (loginId == null){
		// 한글은 인코더의 인코드 메서드를 이용해서 utf-8로 변환 후 재요청해야 한다.
		response.sendRedirect("../loginform.jsp?err=req&job=" + URLEncoder.encode("게시글 등록", "utf-8"));
		return;
	}
	
	Board board = new Board();
	board.setTitle(title);
	board.setContent(content);
	board.setCustomer(new Customer(loginId));
	BoardDao boardDao = new BoardDao();
	
	boardDao.insertBoard(board);
	
	response.sendRedirect("list.jsp?");
%>