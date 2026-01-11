
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Sign up</title>
</head>
<body>
<h2> Sign Up</h2>
<form action="signup" method="post">
    <label>Email: </label>
    <input name="email" type="email" required/>
    <label>Nom: </label>
    <input name="nom" type="text" required/>
    <label>Prenom: </label>
    <input name="prenom" type="text" required/>
    <label>Password: </label>
    <input name="password" type="password"/>

    <select name="role">
        <option value="CANDIDAT">Candidat</option>
        <option value="RECRUTEUR">Recruteur</option>
        <option value="AGENT_UNIV">Agent</option>
        <option value="ADMIN">Admin</option>
    </select>

    <button type="submit">Sign up</button>
</form>
</body>
</html>