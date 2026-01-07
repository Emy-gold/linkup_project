<%--
  Created by IntelliJ IDEA.
  User: ToshiBa
  Date: 1/5/2026
  Time: 11:59 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Sign up</title>
</head>
<body>
    <h2> Sign Up</h2>
    <br action="signup" method="post">
        <label>Email: </label><br/>
        <input name="email" type="email" required/>
        <label>Nom: </label></br>
        <input name="nom" type="text" required/>
        <label>Prenom: </label></br>
        <input name="prenom" type="text" required/>
    <label>Password: </label></br>
        <input name="password" type="password"/>

        <select name="role">
            <option value="CANDIDAT">Candidat</option>
            <option value="RECRUTEUR">Recruteur</option>
            <option value="AGENT">Agent</option>
            <option value="ADMIN">Admin</option>
        </select>
        <button type="submit">Sign up</button>
    </form>
</body>
</html>
