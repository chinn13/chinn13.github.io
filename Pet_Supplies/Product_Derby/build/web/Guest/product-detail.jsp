
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>

<!-- ---------------------------------------- comment ---------------------------------------------- -->
<%
    Integer userId = (Integer) session.getAttribute("user_id");
    String username = null;

    // Check if userId is null
    if (userId != null) {
        // JDBC code to fetch username from the database based on user_id
        try {
            // Establish connection to the database
            Connection conn = DriverManager.getConnection("jdbc:derby://localhost:1527/pet_supplies", "nbuser", "nbuser");

            // Prepare statement
            String query = "SELECT c.username FROM users u JOIN customer c ON u.cust_id = c.cust_id WHERE u.user_id = ?";
            PreparedStatement pstmt = conn.prepareStatement(query);
            pstmt.setInt(1, userId);

            // Execute query
            ResultSet rs = pstmt.executeQuery();

            // Process result
            if (rs.next()) {
                username = rs.getString("username");
            }

            // Close resources
            rs.close();
            pstmt.close();
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Set the username as a request attribute to be accessed in the JSP
    request.setAttribute("logged_in_username", username);
%>
<!-- ---------------------------------------- comment ---------------------------------------------- -->

<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/pet.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/petView.css">
        <link href="css/productcomment.css" rel="stylesheet" type="text/css"/>
        <title>Product</title>
    </head>

    <body>
        <div class="box">            
            <jsp:include page="../HeadFoot/header.jsp"/>

            <p class="path">
                <span><a href="${pageContext.request.contextPath}/Guest/home.jsp">HOME</a><i class="fa fa-chevron-right" aria-hidden="true"></i>Product</span>
            </p>

            <c:if test="${productDetail != null}">
                <form action="${pageContext.request.contextPath}/add-cart?product=${productDetail.id}" method="post" id="productForm">
                    <div class="detail">
                        <div class="left">
                            <img src="${pageContext.request.contextPath}/${productDetail.image}" alt="">
                        </div>
                        <div class="right">                        
                            <h1 class="name">${productDetail.name}</h1>
                            <p> | <span class="review">Be the first to review this product</span></p>
                            <h2 class="price">MYR${String.format("%.2f", productDetail.price)}</h2>
                            <div class="qtySelect">
                                <div>
                                    <button type="button" class="remove">-</button>
                                    <input type="text" class="qty" name="qty" value="1">
                                    <button type="button" class="plus">+</button>
                                </div>
                                <c:choose>
                                    <c:when test="${user_id != null}">
                                        <button type="submit" class="btnSubmit" name="btnSubmit" value="AddToCart">Add To Cart</button>
                                    </c:when>
                                    <c:otherwise>
                                        <button type="submit" class="btnSubmit" name="btnSubmit" value="Login">Login</button>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <p class="earn">Earn <strong>100 points</strong> for writing a review for this product</p>
                        </div>
                    </div>
                    <div class="describe">
                        <div class="describe_field">
                            <p>details</p>
                            <p>reviews</p>
                        </div>
                        <div class="description">${productDetail.description}</div>
                    </div>
                </form>
            </c:if>

            <!-- comment -->
            <div class="CommentBody">
                <div class="container">
                    <div class="head"><h1>Post a Comment</h1></div>
                    <div><span id="comment">0</span> Comments</div>
                    <div class="text"><p style="font-family: cooper black; padding : 5px;">We are happy to hear from you :D</p></div>
                    <div class="comments"></div>
                    <div class="commentbox">
                        <img src="images/user1.png" alt="">
                        <div class="content">
                            <h2>Comment as: </h2>
                            <input type="text" placeholder="Login to leave a comment !" class="user" value="${logged_in_username}" readonly/>
                            <div class="commentinput">
                                <input type="text" placeholder="Enter comment" class="usercomment" />
                                <div class="buttons">
                                    <c:choose>
                                        <c:when test="${user_id != null}">
                                            <button type="submit" disabled id="publish">Publish</button>
                                        </c:when>
                                        <c:otherwise>
                                            <button type="submit" class="btnSubmit" name="btnSubmit" value="Login">Login</button>
                                        </c:otherwise>
                                    </c:choose>
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

            <jsp:include page="../HeadFoot/footer.jsp"/>
        </div>

        <script>
            let total = document.querySelector('.qty');
            let add = document.querySelector('.plus');
            let remove = document.querySelector('.remove');

            add.addEventListener('click', function () {
                total.value++;
                remove.disabled = false;
            });
            remove.addEventListener('click', function () {
                total.value--;
                if (total.value <= 0) {
                    remove.disabled = true;
                }
            });



            //Comment- ------------------------------------------------------------------------------------

            document.addEventListener("DOMContentLoaded", function () {
                const userComment = document.querySelector(".usercomment");
                const publishBtn = document.querySelector("#publish");
                const comments = document.querySelector(".comments");
                const userName = document.querySelector(".user");
                const commentCount = document.getElementById("comment");

                // Load comments from local storage when the page loads
                loadComments();

                userComment.addEventListener("input", () => {
                    if (!userComment.value) {
                        publishBtn.setAttribute("disabled", "disabled");
                        publishBtn.classList.remove("abled");
                    } else {
                        publishBtn.removeAttribute("disabled");
                        publishBtn.classList.add("abled");
                    }
                });

                function addPost() {
                    if (!userComment.value)
                        return;

                    const name = userName.value || "User";
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

                function saveComment(comment) {
                    let commentsArray = JSON.parse(localStorage.getItem("comments")) || [];
                    commentsArray.push(comment);
                    localStorage.setItem("comments", JSON.stringify(commentsArray));
                }

                function loadComments() {
                    let commentsArray = JSON.parse(localStorage.getItem("comments")) || [];
                    commentsArray.forEach(addCommentToUI);
                    updateCommentCount(); // Update comment count when comments are loaded
                }

                function addCommentToUI(comment) {
                    const published = '<div class="parents">' +
                            '<img src="images/user1.png" alt="user image">' +
                            '<div>' +
                            '<h1>' + comment.name + '</h1>' +
                            '<p>' + comment.message + '</p>' +
                            '<span class="date">' + comment.date + '</span>' +
                            '<div class="replies">' + // Container for replies
                            '</div>' +
                            '</div>' +
                            '</div>';
                    comments.insertAdjacentHTML("beforeend", published);
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

                comments.addEventListener("click", deleteComment);
                publishBtn.addEventListener("click", addPost);
            });

        </script>
    </body>

</html>