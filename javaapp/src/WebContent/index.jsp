<%@ page import="java.util.ArrayList" %>
<%
    // Create session-based list
    ArrayList<String> todoList = (ArrayList<String>) session.getAttribute("todos");

    if (todoList == null) {
        todoList = new ArrayList<>();
        session.setAttribute("todos", todoList);
    }

    String action = request.getParameter("action");

    if (action != null) {
        if (action.equals("add")) {
            String task = request.getParameter("task");
            if (task != null && !task.trim().equals("")) {
                todoList.add(task);
            }
        } else if (action.equals("delete")) {
            int index = Integer.parseInt(request.getParameter("index"));
            if (index >= 0 && index < todoList.size()) {
                todoList.remove(index);
            }
        }
    }
%>

<html>
<head>
    <title>Todo List</title>
</head>
<body>

<h2>Todo List</h2>

<!-- Add Task -->
<form method="post">
    <input type="text" name="task" placeholder="Enter task" required>
    <input type="hidden" name="action" value="add">
    <input type="submit" value="Add Task">
</form>

<hr>

<h3>Your Tasks:</h3>

<ul>
<%
    for (int i = 0; i < todoList.size(); i++) {
%>
    <li>
        <%= todoList.get(i) %>
        <form method="post" style="display:inline;">
            <input type="hidden" name="action" value="delete">
            <input type="hidden" name="index" value="<%= i %>">
            <input type="submit" value="Delete">
        </form>
    </li>
<%
    }
%>
</ul>

</body>
</html>