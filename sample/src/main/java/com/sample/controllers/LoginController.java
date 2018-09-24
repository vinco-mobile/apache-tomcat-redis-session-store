package com.sample.controllers;

import com.sample.bean.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "LoginController", urlPatterns = "/login")
public class LoginController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        User user = new User(
                request.getParameter("firstname"),
                request.getParameter("lastname"),
                request.getParameter("email")
        );
        request.getSession().setAttribute("user", user);
        request.getRequestDispatcher("/").forward(request, response);
    }

}
