<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html lang="en">

<head>
</head>

<body>
 <aside class="left-sidebar" data-sidebarbg="skin6">
            <div class="scroll-sidebar" data-sidebarbg="skin6">
                <nav class="sidebar-nav">
                    <ul id="sidebarnav">
                        <li class="sidebar-item"> <a class="sidebar-link sidebar-link" href="/adminDashboard"
                                aria-expanded="false"><i data-feather="home" class="feather-icon"></i><span
                                    class="hide-menu">메인</span></a></li>
                        <li class="list-divider"></li>
                        <li class="nav-small-cap"><span class="hide-menu">Applications</span></li>

                        <li class="sidebar-item"> <a class="sidebar-link" href="/adminMemberStatus"
                                aria-expanded="false"><i data-feather="tag" class="feather-icon"></i><span
                                    class="hide-menu">회원관리
                                </span></a>
                        </li>
                        <li class="sidebar-item"> <a class="sidebar-link has-arrow" href="javascript:void(0)"
                                aria-expanded="false"><i data-feather="file-text" class="feather-icon"></i><span
                                    class="hide-menu">상품관리
                                </span></a>
                            <ul aria-expanded="false" class="collapse  first-level base-level-line">
                                <li class="sidebar-item"><a href="/adminProductStatus" class="sidebar-link">
                                        <span class="hide-menu"> 상품현황
                                        </span></a>
                                </li>
                                <li class="sidebar-item"><a href="/adminProductRegistration" class="sidebar-link">
                                        <span class="hide-menu"> 상품등록
                                        </span></a>
                                </li>

                            </ul>
                        </li>
                        <li class="sidebar-item"> <a class="sidebar-link sidebar-link" href="/adminOrderStatus"
                                aria-expanded="false"><i data-feather="message-square" class="feather-icon"></i><span
                                    class="hide-menu">주문관리</span></a></li>
                        <li class="sidebar-item"> <a class="sidebar-link has-arrow" href="javascript:void(0)"
                                aria-expanded="false"><i data-feather="file-text" class="feather-icon"></i><span
                                    class="hide-menu">매출관리
                                </span></a>
                            <ul aria-expanded="false" class="collapse  first-level base-level-line">
                                <li class="sidebar-item"><a href="/adminSalesStatus" class="sidebar-link"><span
                                            class="hide-menu"> 매출현황
                                        </span></a>
                                </li>
                                <li class="sidebar-item"><a href="/adminDailySalesStatus" class="sidebar-link"><span
                                            class="hide-menu"> 전일대비매출
                                        </span></a>
                                </li>
                                <li class="sidebar-item"><a href="/adminMonthlySalesStatus" class="sidebar-link"><span
                                            class="hide-menu">
                                            월별매출
                                        </span></a>
                                </li>
                            </ul>
                        <li class="list-divider"></li>
                        <li class="sidebar-item"> <a class="sidebar-link sidebar-link" href="/main"
                                aria-expanded="false"><i data-feather="log-out" class="feather-icon"></i><span
                                    class="hide-menu">홈페이지로 이동</span></a></li>
                    </ul>
                </nav>
            </div>
        </aside>
        
        </body>
        </html>