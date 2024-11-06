<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html lang="en">

  <head>
  	<!-- Tailwind CSS -->
    <script src="https://cdn.tailwindcss.com"></script>
    <!-- Alpine.js -->
    <script src="https://cdn.jsdelivr.net/gh/alpinejs/alpine@v2.x.x/dist/alpine.min.js" defer></script>
    <!-- Custom styles -->
    <link href='//spoqa.github.io/spoqa-han-sans/css/SpoqaHanSansNeo.css' rel='stylesheet' type='text/css'>
    
    <style>
  .claude-header {
    background-color: #525354 !important;
    border-bottom: 1px solid #e5e7eb !important;
  }

  .claude-container {
    border-bottom: none !important;
  }

  .claude-breadcrumb {
    margin-right: 75px;
    display: flex;
    align-items: center;
    list-style-type: none;
  }

  .claude-title {
    font-weight: bold;
    font-size: 24px;
  }

  .claude-title a {
    color: #ffffff !important;
    text-decoration: none;
  }

  .header-nav .nav-link {
    color: #ffffff !important;
    transition: color 0.2s ease-in-out;
  }
  
  .header-nav .nav-link:hover {
    color: #10a37f !important;
  }

  .dropdown-menu {
    background-color: #ffffff !important;
    border: 1px solid #e5e7eb !important;
    box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06) !important;
  }
  
  .dropdown-toggle {
  	color: #ffffff !important;
  	font-size: 30px;
  }
  
  .dropdown-item {
  	color: #1a2133 !important;
  }

  .dropdown-item:hover {
    background-color: #f3f4f6 !important;
  }

        [x-cloak] { display: none; }
        .transition { transition: all 0.3s ease-out; }
        .status-buttons { display: none; }
        .modal-dialog { max-width: 80%; }
        .search-container { display: flex; margin-bottom: 20px; }
        .search-group { display: flex; align-items: center; }
        .table-container { margin-top: 20px; }
        .clickable-row { cursor: pointer; }
        .selected { background-color: #e0e0e0; }
        .menu-open #tableContainer {
        margin-top: 76px; /* 하위 메뉴의 높이에 맞춰 조정하세요 */
	    }
	    #statusMenu {
	        transition: all 0.3s ease-in-out;
	        opacity: 0;
	        transform: translateY(-10px);
	    }
	    #statusMenu.active {
	        opacity: 1;
	        transform: translateY(0);
	    }
	    * { font-family: 'Spoqa Han Sans Neo', 'sans-serif'; }
	    
	.transition-all {
	    transition: all 0.3s ease-in-out;
	}
	
	#dynamicTable {
	    min-height: 0px;
	    max-height: 1000px;
	}
	
	.table-header-sticky {
	    position: sticky;
	    top: 0;
	    background: ;
	    z-index: 10;
	    box-shadow: 0 1px 2px rgba(0,0,0,0.1);
	}
	
	tr:first-child {
	    height: 40px;  /* 첫 행의 높이를 60px로 설정 */
  	}
	
	.checkbox-column {
            width: 40px; /* 원하는 고정 너비 */
    }
	
    </style>
    
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
    <meta name="description" content="CoreUI - Bootstrap Admin Template">
    <meta name="author" content="Łukasz Holeczek">
    <meta name="keyword" content="Bootstrap,Admin,Template,SCSS,HTML,RWD,Dashboard">
    <meta name="_csrf" content="${_csrf.token}"/>
    <meta name="_csrf_header" content="${_csrf.headerName}"/>
    <title>Styleboso</title>
    <link rel="apple-touch-icon" sizes="57x57" href="#">
    <link rel="apple-touch-icon" sizes="60x60" href="#">
    <link rel="apple-touch-icon" sizes="72x72" href="#">
    <link rel="apple-touch-icon" sizes="76x76" href="#">
    <link rel="apple-touch-icon" sizes="114x114" href="#">
    <link rel="apple-touch-icon" sizes="120x120" href="#">
    <link rel="apple-touch-icon" sizes="144x144" href="#">
    <link rel="apple-touch-icon" sizes="152x152" href="#">
    <link rel="apple-touch-icon" sizes="180x180" href="#">
    <link rel="icon" type="image/png" sizes="192x192" href="#">
    <link rel="icon" type="image/png" sizes="32x32" href="#">
    <link rel="icon" type="image/png" sizes="96x96" href="#">
    <link rel="icon" type="image/png" sizes="16x16" href="#">
<!--     <link rel="manifest" href="assets/favicon/manifest.json"> -->
    <meta name="msapplication-TileColor" content="#ffffff">
    <meta name="msapplication-TileImage" content="#">
    <meta name="theme-color" content="#ffffff">
    <!-- Vendors styles-->
    <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/vendors/simplebar/css/simplebar.css">
    <!-- Main styles for this application-->
    <link href="${pageContext.request.contextPath }/resources/css/style.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath }/resources/css/examples.css" rel="stylesheet">
    <script src="/resources/js/config.js"></script>
    <script src="/resources/js/color-modes.js"></script>
    <link href="${pageContext.request.contextPath }/resources/vendors/@coreui/chartjs/css/coreui-chartjs.css" rel="stylesheet">
  
      <header class="header header-sticky p-0 mb-4 claude-header">
		  <div class="container-fluid px-4 border-bottom claude-container">
		    <ol class="breadcrumb my-0 claude-breadcrumb" style="margin-right:75px; display: flex; align-items: center; list-style-type: none;">
		      <li class="avatar avatar-md" style="margin-right: 10px;">
		        <img src="/resources/img/hangers.png" alt="Logo" style="width: 40px; height: 40px;">
		      </li>
		      <li class="breadcrumb-item claude-title">
		        <a href="/loginout/main">Styleboso</a>
		      </li>
		    </ol>
          <a class="nav-link dropdown-toggle" href="#" role="button" data-coreui-toggle="dropdown" aria-expanded="false" style="margin-right:30px;">
            시스템
          </a>
          <ul class="dropdown-menu">
            <li><a class="dropdown-item" href="/system/employeeList">사용자 관리</a></li>
            <li><a class="dropdown-item" href="/system/code/common">공통코드 관리</a></li>
          </ul>
          <a class="nav-link dropdown-toggle" href="#" role="button" data-coreui-toggle="dropdown" aria-expanded="false" style="margin-right:30px;">
            기본정보
          </a>
          <ul class="dropdown-menu">
            <li><a class="dropdown-item" href="/basicInfo/itemList">품목 관리</a></li>
            <li><a class="dropdown-item" href="/basicInfo/clientList">거래처 관리</a></li>
            <li><a class="dropdown-item" href="/basicInfo/warehouseList">창고 관리</a></li>
          </ul>
          <a class="nav-link dropdown-toggle" href="#" role="button" data-coreui-toggle="dropdown" aria-expanded="false" style="margin-right:30px;">
            영업
          </a>
          <ul class="dropdown-menu">
            <li><a class="dropdown-item" href="/sales/salesOrderList">수주 관리</a></li>
            <li><a class="dropdown-item" href="/sales/purchaseOrderList">발주 관리</a></li>
          </ul>
          <a class="nav-link dropdown-toggle" href="#" role="button" data-coreui-toggle="dropdown" aria-expanded="false" style="margin-right:30px;">
            재고
          </a>
          <ul class="dropdown-menu">
            <li><a class="dropdown-item" href="/stock/status">재고 현황</a></li>
            <li class="dropdown-submenu">
	          <a class="dropdown-item" href="/stock/adjustment/return">반품 관리</a>
	          	<ul class="dropdown-menu">
	            	<li><a class="dropdown-item" href="/stock/adjustment/exchange">교환</a></li>
	            	<li><a class="dropdown-item" href="/stock/adjustment/return">반품</a></li>
	          	</ul>
        	</li>
            <li><a class="dropdown-item" href="/stock/receivingList">입고 관리</a></li>
            <li><a class="dropdown-item" href="/stock/releaseList">출고 관리</a></li>
          </ul>
          <ul class="header-nav d-none d-md-flex ms-auto">
            
          </ul>
          <ul class="header-nav ms-auto ms-md-0">
            <li class="nav-item dropdown">
              <ul class="dropdown-menu dropdown-menu-end" style="--cui-dropdown-min-width: 8rem;">
                <li>
                  <button class="dropdown-item d-flex align-items-center" type="button" data-coreui-language-value="en" onclick="i18next.changeLanguage(&quot;en&quot;)">
                    <svg class="icon icon-lg me-3">
                      <use xlink:href="/resources/vendors/@coreui/icons/svg/flag.svg#cif-gb"></use>
                    </svg>English
                  </button>
                </li>
                <li>
                  <button class="dropdown-item d-flex align-items-center" type="button" data-coreui-language-value="es" onclick="i18next.changeLanguage(&quot;es&quot;)">
                    <svg class="icon icon-lg me-3">
                      <use xlink:href="/resources/vendors/@coreui/icons/svg/flag.svg#cif-es"></use>
                    </svg>Español
                  </button>
                </li>
                <li>
                  <button class="dropdown-item d-flex align-items-center" type="button" data-coreui-language-value="pl" onclick="i18next.changeLanguage(&quot;pl&quot;)">
                    <svg class="icon icon-lg me-3">
                      <use xlink:href="/resources/vendors/@coreui/icons/svg/flag.svg#cif-pl"></use>
                    </svg>Polski
                  </button>
                </li>
              </ul>
            </li>
            <li class="nav-item dropdown">
              <button class="btn btn-link nav-link" type="button" aria-expanded="false" data-coreui-toggle="dropdown">
                <svg class="icon icon-lg theme-icon-active">
                  <use xlink:href="/resources/vendors/@coreui/icons/svg/free.svg#cil-contrast"></use>
                </svg>
              </button>
              <ul class="dropdown-menu dropdown-menu-end" style="--cui-dropdown-min-width: 8rem;">
                <li>
                  <button class="dropdown-item d-flex align-items-center" type="button" data-coreui-theme-value="light">
                    <svg class="icon icon-lg me-3">
                      <use xlink:href="/resources/vendors/@coreui/icons/svg/free.svg#cil-sun"></use>
                    </svg><span data-coreui-i18n="light">Light</span>
                  </button>
                </li>
                <li>
                  <button class="dropdown-item d-flex align-items-center" type="button" data-coreui-theme-value="dark">
                    <svg class="icon icon-lg me-3">
                      <use xlink:href="/resources/vendors/@coreui/icons/svg/free.svg#cil-moon"></use>
                    </svg><span data-coreui-i18n="dark"> Dark</span>
                  </button>
                </li>
                <li>
                  <button class="dropdown-item d-flex align-items-center active" type="button" data-coreui-theme-value="auto">
                    <svg class="icon icon-lg me-3">
                      <use xlink:href="/resources/vendors/@coreui/icons/svg/free.svg#cil-contrast"></use>
                    </svg>Auto
                  </button>
                </li>
              </ul>
            </li>
            <li class="nav-item py-1">
              <div class="vr h-100 mx-2 text-body text-opacity-75"></div>
            </li>
            <li class="nav-item dropdown"><a class="nav-link py-0" data-coreui-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false">
            <div class="avatar avatar-md">
			  <img src="https://cdn.pixabay.com/photo/2022/01/30/13/33/github-6980894_1280.png" alt="user@email.com">
			</div>
<!-- 			<span class="ms-2"> -->
<%-- 		      <sec:authentication property="" />  --%>
<%-- 		      <sec:authentication property="" /> --%>
<!-- 		    </span> -->
              </a>
              <div class="dropdown-menu dropdown-menu-end pt-0">
                <div class="dropdown-header bg-body-tertiary text-body-secondary fw-semibold rounded-top mb-2" data-coreui-i18n="account">Account</div><a class="dropdown-item" href="#">
                  <svg class="icon me-2">
                    <use xlink:href="/resources/vendors/@coreui/icons/svg/free.svg#cil-bell"></use>
                  </svg><span data-coreui-i18n="updates">Updates</span><span class="badge badge-sm bg-info-gradient ms-2">42</span></a><a class="dropdown-item" href="#">
                  <svg class="icon me-2">
                    <use xlink:href="/resources/vendors/@coreui/icons/svg/free.svg#cil-envelope-open"></use>
                  </svg><span data-coreui-i18n="messages">Messages</span><span class="badge badge-sm badge-sm bg-success ms-2">42</span></a><a class="dropdown-item" href="#">
                  <svg class="icon me-2">
                    <use xlink:href="/resources/vendors/@coreui/icons/svg/free.svg#cil-task"></use>
                  </svg><span data-coreui-i18n="tasks">Tasks</span><span class="badge badge-sm bg-danger-gradient ms-2">42</span></a><a class="dropdown-item" href="#">
                  <svg class="icon me-2">
                    <use xlink:href="/resources/vendors/@coreui/icons/svg/free.svg#cil-comment-square"></use>
                  </svg><span data-coreui-i18n="comments">Comments</span><span class="badge badge-sm bg-warning-gradient ms-2">42</span></a>
                <div class="dropdown-header bg-body-tertiary text-body-secondary fw-semibold my-2" data-coreui-i18n="settings">Settings</div><a class="dropdown-item" href="#">
                  <svg class="icon me-2">
                    <use xlink:href="/resources/vendors/@coreui/icons/svg/free.svg#cil-user"></use>
                  </svg><span data-coreui-i18n="profile">Profile</span></a><a class="dropdown-item" href="#">
                  <svg class="icon me-2">
                    <use xlink:href="/resources/vendors/@coreui/icons/svg/free.svg#cil-settings"></use>
                  </svg><span data-coreui-i18n="settings">Settings</span></a><a class="dropdown-item" href="#">
                  <svg class="icon me-2">
                    <use xlink:href="/resources/vendors/@coreui/icons/svg/free.svg#cil-credit-card"></use>
                  </svg><span data-coreui-i18n="payments">Payments</span><span class="badge badge-sm bg-secondary-gradient text-dark ms-2">42</span></a><a class="dropdown-item" href="#">
                  <svg class="icon me-2">
                    <use xlink:href="/resources/vendors/@coreui/icons/svg/free.svg#cil-file"></use>
                  </svg><span data-coreui-i18n="projects">Projects</span><span class="badge badge-sm bg-primary-gradient ms-2">42</span></a>
                <div class="dropdown-divider"></div><a class="dropdown-item" href="#">
                  <svg class="icon me-2">
                    <use xlink:href="/resources/vendors/@coreui/icons/svg/free.svg#cil-lock-locked"></use>
                  </svg><span data-coreui-i18n="lockAccount">Lock Account</span></a>
                  <!-- 로그아웃 -->
                <a class="dropdown-item" href="#">
				  <form action="./logout" method="post" id="logout">
				    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
				    <svg class="icon me-2">
				      <use xlink:href="/resources/vendors/@coreui/icons/svg/free.svg#cil-account-logout"></use>
				    </svg>
				    <button type="button"  style="background:none; border:none; padding:0; margin:0;">
				      <span data-coreui-i18n="logout">Logout</span>
				    </button>
				  </form>
				</a>
              </div>
            </li>
          </ul>
        </div>
      </header>
      
<!-- </div> -->
    </head>
    
    <!-- jQuery -->
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<!-- sweet alert -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <!-- 로그아웃  -->
    
<script>
    $(document).on("click", "#logout", function() {
        Swal.fire({
            title: "로그아웃 하시겠습니까?",
            icon: "warning",
            showCancelButton: true,
            confirmButtonColor: "#3085d6",
            cancelButtonColor: "#d33",
            confirmButtonText: "네",
            cancelButtonText: "취소"
        }).then((result) => {
            if (result.isConfirmed) {
                document.getElementById('logout').submit(); // 폼을 제출합니다.
            }
        });
    });

    document.addEventListener('DOMContentLoaded', function() {
	    // 테이블 높이를 동적으로 조절하는 함수
	    function adjustTableHeight() {
	        const tableContainer = document.getElementById('dynamicTable');
	        const table = tableContainer.querySelector('table');
	        const rows = table.querySelectorAll('tbody tr');
	        
	        // 기본 설정
	        const rowHeight = 48; // 각 행의 예상 높이
	        const headerHeight = 48; // 헤더의 높이
	        const minHeight = 200; // 최소 높이
	        const maxHeight = 600; // 최대 높이
	        
	        // 실제 데이터 행 수에 따른 높이 계산
	        const calculatedHeight = (rows.length * rowHeight) + headerHeight;
	        
	        // 최소/최대 높이 제한 적용
	        const finalHeight = Math.max(minHeight, Math.min(calculatedHeight, maxHeight));
	        
	        // 테이블 컨테이너 높이 설정
	        tableContainer.style.height = `${finalHeight}px`;
	    }
	    
	    // 페이지 로드 시 테이블 높이 조절
	    adjustTableHeight();
	    
	    // 테이블 헤더를 고정하기 위한 설정
	    const headers = document.querySelectorAll('thead th');
	    headers.forEach(header => {
	        header.classList.add('table-header-sticky');
	    });
	    
	    // 창 크기 변경 시 테이블 높이 재조정
	    window.addEventListener('resize', adjustTableHeight);
	});
	
	// 검색 결과가 업데이트될 때 테이블 높이 재조정 (필요한 경우)
	function onSearchComplete() {
	    adjustTableHeight();
	}
</script> 