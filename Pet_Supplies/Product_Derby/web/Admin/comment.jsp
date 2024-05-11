<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.awt.event.*" %>
<%@ page import="javax.swing.*;" %>


<%   
    String host = "jdbc:derby://localhost:1527/pet_supplies";
    String user = "nbuser";
    String password = "nbuser";
    String tableName = "comment";
    Connection conn = null; 
    PreparedStatement stmt = null; 
%>


<!DOCTYPE html>
<html lang="en">
<head>
    <link href="${pageContext.request.contextPath}/css/comment.css" rel="stylesheet" type="text/css"/>
    <link href="${pageContext.request.contextPath}/css/pet.css" rel="stylesheet" type="text/css"/>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>UI/UX Comment Section Design </title>
</head>
<body>
    
       <jsp:include page="/all"/>

        <div class="box">
            <jsp:include page="../HeadFoot/header.jsp"/>

            <div class="adminbar">
                <jsp:include page="../HeadFoot/LeftBar.jsp"/>
    

<div class="CommentBody">
    <div class="container">
        <div class="head"><h1>Comment Control</h1></div>
        <div><span id="comment">0</span> Comments</div>
        <div class="text"><p style="font-family: cooper black; padding : 5px;"></p></div>
        <div class="comments">
            <% 
                try {
                    Class.forName("org.apache.derby.jdbc.ClientDriver");
                    conn = DriverManager.getConnection(host, user, password);

                    // Retrieve comments from the database
                    String selectSql = "SELECT * FROM " + tableName + " ORDER BY datetime DESC";
                    stmt = conn.prepareStatement(selectSql);
                    ResultSet rs = stmt.executeQuery();

                    // Display comments on the webpage
                    while (rs.next()) {
                        String name = rs.getString("name");
                        String message = rs.getString("message");
                        Timestamp datetime = rs.getTimestamp("datetime");
            %>
            <div class="parents">
                <img src="../images/user1.png" alt="user image">
                <div>
                    <h1><%= name %></h1>
                    <p><%= message %></p>
                    <span class="date"><%= datetime %></span>
                    <button class="reply-btn">Reply</button>
                    <div class="reply-form">
                     <input type="text" class="reply-comment" placeholder="Enter your reply">
                    <button class="submit-reply">Submit</button>
                 </div>
                    <div class="replies"></div>
                </div>
            </div>
            <%
                    }
                } catch (SQLException e) {
                    out.println("Database Error: " + e.getMessage());
                } catch (ClassNotFoundException e) {
                    out.println("Error loading JDBC Driver: " + e.getMessage());
                } finally {
                    try {
                        if (stmt != null) stmt.close();
                        if (conn != null) conn.close();
                    } catch (SQLException e) {
                        out.println("Error closing database connection: " + e.getMessage());
                    }
                }
            %>
        </div>
        <div class="commentbox">
            <img src="../images/user1.png" alt="">
            <div class="content">
                <h2>Comment as: </h2>
                <input type="text" placeholder="Admin ✅" class="user" readonly>

                <div class="commentinput">
                    <input type="text" placeholder="Enter comment" class="usercomment" />
                    <div class="buttons">
                        <button type="submit" disabled id="publish">Publish</button>
                        <div class="notify">
                            <input type="checkbox" class="notifyinput"> <span>Notify me</span>
                        </div>
                    </div>
                </div>
                <p class="policy">This site is protected by reCAPTCHA and the Google <a href="">privacy policy</a> and <a href="">Terms of Service</a> apply.</p>
              </div>
             </div>
            </div>  
           </div> 
        </div>  
         <jsp:include page="../HeadFoot/footer.jsp"/>
      
</div>
            
<script type="text/javascript">
    
//Comment ------------------------------------------------------------------------------------
document.addEventListener("DOMContentLoaded", function() {
    const userComment = document.querySelector(".usercomment");
    const publishBtn = document.querySelector("#publish");
    const comments = document.querySelector(".comments");
    const userName = document.querySelector(".user");
    const commentCount = document.getElementById("comment");


    // Load comments from local storage when the page loads
    loadComments();

    <!---Publish Comment Event Section ---->
    userComment.addEventListener("input", () => {
        if (!userComment.value) {
            publishBtn.setAttribute("disabled", "disabled");
            publishBtn.classList.remove("abled");
        } else {
            publishBtn.removeAttribute("disabled");
            publishBtn.classList.add("abled");
        }
    });
  
   <!----ADD POST FUNCTION---->
    function addPost() {
        if (!userComment.value) return;

        const name = userName.value || "Admin ✅";
        const message = userComment.value || "No message provided";
        const date = new Date().toLocaleString();

        const comment = {
            name: name,
            message: message,
            date: date,
            replies: []
        };

        // Save comment to local storage
        saveComment(comment);

        // Add comment to UI
        addCommentToUI(comment);

        userComment.value = "";
        publishBtn.classList.remove("abled");

        // Update comment count
        updateCommentCount();

        // Update the comment count displayed
        let commentsNum = document.querySelectorAll(".parents").length;
        commentCount.textContent = commentsNum;
    }

    <!---Comment Local Storage --->
    function saveComment(comment) {
        let commentsArray = JSON.parse(localStorage.getItem("comments")) || [];
        commentsArray.push(comment);
        localStorage.setItem("comments", JSON.stringify(commentsArray));
         if (comment.message) {
        console.log("Comment saved to local storage:", comment);
    } else {
        console.log("Reply saved to local storage:", comment);
    }
}


<!----Function to save comments to local storage-->
function saveComments(commentsArray) {
    localStorage.setItem("comments", JSON.stringify(commentsArray));
}

    function loadComments() {
        let commentsArray = JSON.parse(localStorage.getItem("comments")) || [];
        commentsArray.forEach(addCommentToUI);
        updateCommentCount(); // Update comment count when comments are loaded
    }

    function addCommentToUI(comment) {
        const published = '<div class="parents">' +
                            '<img src="../images/user1.png" alt="user image">' +
                            '<div>' +
                                '<h1>' + comment.name + '</h1>' +
                                '<p>' + comment.message + '</p>' +
                                '<span class="date">' + comment.date + '</span>' +
                                '<button class="delete-btn">Delete</button>' +
                                '<button class="reply-btn">Reply</button>' +
                                '<div class="reply-form" style="display: none;">' +
                                '<input type="text" class="reply-comment" placeholder="Enter your reply">' +
                                '<button class="submit-reply">Submit</button>' +
                            '</div>' +
                            '<div class="replies">' + // Container for replies
                             '</div>' +
                            '</div>' +
                        '</div>';
        comments.insertAdjacentHTML("beforeend", published);
        
        // Add any stored replies to this comment
        if (comment.replies) {
            comment.replies.forEach(reply => {
                addReplyToComment(comments.lastElementChild, reply);
            });
        }
    }
    

    function deleteComment(e) {
        if (e.target.classList.contains("delete-btn")) {
            const commentDiv = e.target.closest(".parents");
            const commentIndex = Array.from(comments.children).indexOf(commentDiv);
            deleteCommentFromLocalStorage(commentIndex);
            commentDiv.remove();
            updateCommentCount(); // Update comment count after deleting a comment
        }
    }

    function deleteCommentFromLocalStorage(index) {
        let commentsArray = JSON.parse(localStorage.getItem("comments")) || [];
        commentsArray.splice(index, 1);
        localStorage.setItem("comments", JSON.stringify(commentsArray));
    }

    function updateCommentCount() {
        let commentsNum = document.querySelectorAll(".parents").length;
        commentCount.textContent = commentsNum;
    }
    
    <!---- Add reply to a comment --->
    function addReplyToComment(commentDiv, reply) {
        const repliesSection = commentDiv.querySelector(".replies");
        const replyHTML = '<div class="reply">' +
                            '<p><strong>' + reply.name + ':</strong> ' + reply.message + '</p>' +
                            '<span class="date">' + reply.date + '</span>' +
                          '</div>';
        repliesSection.insertAdjacentHTML("beforeend", replyHTML);
    }

    function submitReply(e) {
        const commentDiv = e.target.closest(".parents");
        const replyInput = commentDiv.querySelector(".reply-comment");
        const replyMessage = replyInput.value.trim();
        if (replyMessage !== "") {
            const name = "Admin ✅";
            const date = new Date().toLocaleString();

            const reply = {
                name: name,
                message: replyMessage,
                date: date
            };

            // Save reply to local storage
            saveComment(reply);

            // Add reply to UI
            const replyHTML = '<div class="reply">' +
                                '<p><strong>' + reply.name + ':</strong> ' + reply.message + '</p>' +
                                '<span class="date">' + reply.date + '</span>' +
                              '</div>';
            const repliesSection = commentDiv.querySelector(".replies");
            repliesSection.insertAdjacentHTML("beforeend", replyHTML);

            // Clear reply input
            replyInput.value = "";
        }
    }

    function showReplyForm(e) {
    console.log("Reply button clicked");
    const commentDiv = e.target.closest(".parents");
    console.log("Comment div:", commentDiv);
    const replyForm = commentDiv.querySelector(".reply-form");
    if (replyForm) {
        replyForm.style.display = "block";
    } else {
        console.error("Reply form not found");
    }
}

    comments.addEventListener("click", deleteComment);
    comments.addEventListener("click", function(e) {
        if (e.target.classList.contains("submit-reply")) {
            const commentDiv = e.target.closest(".parents");
            const replyInput = commentDiv.querySelector(".reply-comment");
            const replyMessage = replyInput.value.trim();
            if (replyMessage !== "") {
                const name = "Admin ✅";
                const date = new Date().toLocaleString();
                const reply = {
                    name: name,
                    message: replyMessage,
                    date: date
                };
                
                 addReplyToComment(commentDiv, reply);
                 
                 
                 // Save reply to local storage
            const commentIndex = Array.from(comments.children).indexOf(commentDiv);
            let commentsArray = JSON.parse(localStorage.getItem("comments")) || [];
            if (!commentsArray[commentIndex].replies) {
                commentsArray[commentIndex].replies = []; // Initialize replies array if not present
            }
            commentsArray[commentIndex].replies.push(reply);
            saveComments(commentsArray); // Use saveComments instead of saveComment

            // Clear reply input
            replyInput.value = "";
            }
        }
    });
    
    comments.addEventListener("click", function(e) {
        if (e.target.classList.contains("reply-btn")) {
            showReplyForm(e);
        }
    });
    publishBtn.addEventListener("click", addPost);
});
</script>
</body>
</html>