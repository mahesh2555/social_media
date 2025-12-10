<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Social Media - Static Demo</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f4f4f4;
            margin: 0;
            padding: 0;
        }
        .navbar {
            background: #1877f2;
            padding: 10px 20px;
            color: #fff;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }
        .navbar .logo {
            font-size: 22px;
            font-weight: bold;
        }
        .navbar .user {
            font-size: 14px;
        }
        .container {
            max-width: 800px;
            margin: 20px auto;
        }
        .card {
            background: #fff;
            border-radius: 8px;
            padding: 15px;
            margin-bottom: 15px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }
        .card-header {
            font-weight: bold;
            margin-bottom: 5px;
        }
        .timestamp {
            font-size: 12px;
            color: #777;
            float: right;
        }
        .card-body {
            margin-top: 10px;
            font-size: 14px;
        }
        .new-post-box {
            background: #fff;
            border-radius: 8px;
            padding: 15px;
            margin-bottom: 20px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }
        textarea {
            width: 100%;
            resize: vertical;
            min-height: 60px;
            padding: 8px;
            font-family: inherit;
        }
        .btn {
            background: #1877f2;
            border: none;
            color: #fff;
            padding: 8px 16px;
            margin-top: 10px;
            border-radius: 4px;
            cursor: not-allowed; /* just a demo, no backend */
        }
    </style>
</head>
<body>

<div class="navbar">
    <div class="logo">Social Media</div>
    <div class="user">Logged in as <strong>demo_user</strong></div>
</div>

<div class="container">

    <!-- New Post (static, no backend) -->
    <div class="new-post-box">
        <h3>Create a Post</h3>
        <textarea placeholder="What's on your mind? (Demo only, no save) changes commited here"></textarea>
        <br>
        <button class="btn">Post (Demo)</button>
    </div>

    <!-- Static Post 1 -->
    <div class="card">
        <div class="card-header">
            Alice
            <span class="timestamp">Today · 10:00 AM</span>
        </div>
        <div class="card-body">
            Just deployed my first Java web app using JSP and Tomcat! 🎉
        </div>
    </div>

    <!-- Static Post 2 -->
    <div class="card">
        <div class="card-header">
            Bob
            <span class="timestamp">Yesterday · 6:45 PM</span>
        </div>
        <div class="card-body">
            Learning how to build a social media UI step by step. This page is fully static!
        </div>
    </div>

    <!-- Static Post 3 -->
    <div class="card">
        <div class="card-header">
            Charlie
            <span class="timestamp">2 days ago · 3:20 PM</span>
        </div>
        <div class="card-body">
            Once backend is ready, these posts can come from a database or a servlet.
        </div>
    </div>

</div>

</body>
</html>
