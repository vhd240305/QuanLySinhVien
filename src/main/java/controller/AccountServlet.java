package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Account;

import java.io.IOException;

import dao.AccountDAO;

@WebServlet("/admin/accounts")
public class AccountServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		HttpSession session = request.getSession();

		Account acc = (Account) session.getAttribute("account");

		if (acc == null || !acc.getRole().equals("admin")) {
			response.sendRedirect("../view/auth/login.jsp");
			return;
		}

		String action = request.getParameter("action");

		AccountDAO dao = new AccountDAO();

		if (action == null) {

			String keyword = request.getParameter("keyword");

			if (keyword != null && !keyword.isEmpty()) {
				request.setAttribute("list", dao.search(keyword));
			} else {
				request.setAttribute("list", dao.getAll());
			}

			request.getRequestDispatcher("/view/admin/account-list.jsp").forward(request, response);

		} else if ("add".equals(action)) {

			request.getRequestDispatcher("/view/admin/account-add.jsp").forward(request, response);

		} else if ("edit".equals(action)) {

			int id = Integer.parseInt(request.getParameter("id"));

			request.setAttribute("account", dao.getById(id));

			request.getRequestDispatcher("/view/admin/account-edit.jsp").forward(request, response);

		} else if ("delete".equals(action)) {

			int id = Integer.parseInt(request.getParameter("id"));

			dao.delete(id);

			response.sendRedirect("accounts");
		}
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String action = request.getParameter("action");

		AccountDAO dao = new AccountDAO();

		if ("insert".equals(action)) {

			Account a = new Account();

			a.setUsername(request.getParameter("username"));
			a.setPassword(request.getParameter("password"));
			a.setRole(request.getParameter("role"));

			dao.insert(a);

		} else if ("update".equals(action)) {

			Account a = new Account();

			a.setId(Integer.parseInt(request.getParameter("id")));
			a.setUsername(request.getParameter("username"));
			a.setPassword(request.getParameter("password"));
			a.setRole(request.getParameter("role"));

			dao.update(a);
		}

		response.sendRedirect("accounts");
	}
}
