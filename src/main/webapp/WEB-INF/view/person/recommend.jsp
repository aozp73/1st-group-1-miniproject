<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ include file="../layout/header.jsp" %>

        <div class="select_box jm_select_box mt-5">
            <select id="skill" class="jm_select selectpicker" data-style="btn-info" name="">
                <option value="none" selected>분야</option>
                <option value="Java">Java</option>
                <option value="Springboot">Springboot</option>
                <option value="C">C</option>
                <option value="CSS">CSS</option>
                <option value="html">Html</option>
                <option value="Flutter">Flutter</option>
                <option value="JavaScript">JavaScript</option>
            </select>
            <select id="career" class="jm_select" name="">
                <option value="none" selected>고용형태</option>
                <option value="신입">신입</option>
                <option value="경력">경력</option>
            </select>
            <select id="address" class="jm_select" name="">
                <option value="none" selected>근무지</option>
                <option value="경기">전국</option>
                <option value="경기">경기</option>
                <option value="서울">서울</option>
                <option value="부산">부산</option>
                <option value="경기">경남</option>
                <option value="제주">제주</option>
                <option value="울산">울산</option>
            </select>
            <select id="size" class="jm_select" name="">
                <option value="none" selected>규모</option>
                <option value="10_down">10명 이하</option>
                <option value="10_up">10명 이상</option>
                <option value="20">20명 이상</option>
                <option value="50">50명 이상</option>
                <option value="100">100명 이상</option>
            </select>
        </div>


        <div class="container jm_container mt-5">
            <div class="row row-cols-3 g-4 d-flex flex-wrap">
                <c:forEach items="${postList}" var="post">
                    <div class="col-xs-4">
                        <a href="/person/detail/${post.postId}" style="color: inherit; text-decoration: none;">
                            <div class="card jm_card h-100">
                                <img src="${post.logo}" class="card-img-top jm_card_img_top">
                                <div class="card-body jm_card_body">
                                    <div class="jm_company_name">${post.name}</div>
                                    <div class="jm_company_title">${post.title}</div>
                                    <div class="jm_company_address">${post.address}</div>
                                    <div class="jm_D-day d-flex justify-content-between">
                                        <div id="deadlineBox">
                                            <c:choose>
                                                <c:when test="${post.deadline == 0}">
                                                    오늘 마감
                                                </c:when>

                                                <c:otherwise>
                                                    D-${post.deadline}
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                        <input type="hidden" id="postId" value="${post.postId}">
                                        <!--<%--  구독? 스크랩 버튼  --%>-->
                                        <button type="button" class="btn btn-sm" onclick="scrapOrCancle(event)">
                                            <c:choose>
                                                <c:when test="${post.scrap == 0}">
                                                    <i class="fa-regular fa-thumbs-up fa-2xl" id="scrap"
                                                        value="${post.scrap}"></i>
                                                </c:when>

                                                <c:otherwise>
                                                    <i class="fa-solid fa-thumbs-up fa-2xl" id="scrap"
                                                        value="${post.scrap}"></i>

                                                </c:otherwise>
                                            </c:choose>
                                        </button>
                                    </div>
                                </div>
                            </div>

                        </a>
                    </div>
                </c:forEach>
            </div>

        </div>
        <script>
            let postId = $("#postId").val();
            
            function scrapOrCancle() {
                event.preventDefault();
                let scrapValue = $("#scrap").attr("value");
                
                let data = {
                    "postId" : postId
                };

            if (scrapValue == 0) {
                // insert
                $.ajax({
                    type : "put",
                    url : "/person/scrap/" + postId,
                    data : JSON.stringify(data),
                    dateType : "JSON",
                     headers: {
                         "Content-Type": "application/json; charset=UTF-8"
                         }
                }).done((res) => {
                     $("#scrap").attr("value", 1);
                     $("#scrap").addClass("fa-solid");
                        $("#scrap").removeClass("fa-regular");
                }).fail((err)=>{
                    alert(err.responseJSON.msg);
                });                
            } else {
                $.ajax({
                    type : "delete",
                    url : "/person/scrap/" + postId,
                     dateType : "JSON"
                }).done((res) => {
                     $("#scrap").attr("value", 0);
                     $("#scrap").addClass("fa-regular");
                        $("#scrap").removeClass("fa-solid");
                }).fail((err)=>{
                    alert(err.responseJSON.msg);
                });                
            }
            }


        </script>
        <%@ include file="../layout/footer.jsp" %>