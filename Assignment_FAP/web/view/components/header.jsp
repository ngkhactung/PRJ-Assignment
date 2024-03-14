<%-- 
    Document   : header
    Created on : Mar 13, 2024, 4:55:39 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <body>
        <div id="header" class="container">
            <div class="row p-4">
                <div class="col-xxl-6 col-lg-8 col-md-8 col-12">
                    <div class="row align-items-center">
                        <div class="col-md-3 col-12 text-md-start text-center ">
                            <img class="img-fluid" src="../image/logo/fpt-logo-rbg-fpt.webp" width="180px" height="80px">
                        </div>
                        <div class="col-md-9 col-12 text-md-start text-center ">
                            <h1 class="title">University Academic Portal</h1>
                        </div>
                    </div>
                </div>
                <div class="col-xxl-6 col-lg-4 col-md-4 col-12 d-md-grid d-none">
                    <div class="row justify-content-end  align-items-center">
                        <div class="col-xxl-3 col-lg-5 col-md-6">
                            <div class="d-grid gap-2">
                                <button class="btn btn-dark" onclick="window.location.href = 'profile'">
                                    <i class="fa-regular fa-user"></i>
                                    Profile
                                </button>
                            </div>
                        </div>
                        <div class="col-xxl-3 col-lg-5 col-md-6">
                            <div class="d-grid gap-2">
                                <button onclick="window.location.href = '/assign.fap.fpt/logout'"
                                        class="btn btn-outline-dark">
                                    <i class="fas fa-sign-out-alt"></i>
                                    Sign out
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
