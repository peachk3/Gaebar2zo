<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="../include/header.jsp" %>

	<body>
      <div class="body flex-grow-1">
        <div class="container-lg px-4">
          <div class="row g-4 mb-4">
            <div class="col-sm-6 col-xl-3">
              <div class="card text-white bg-primary-gradient">
                <div class="card-body pb-0 d-flex justify-content-between align-items-start">
                  <div>
                    <div class="fs-4 fw-semibold">26K <span class="fs-6 fw-normal">(-12.4%
                        <svg class="icon">
                          <use xlink:href="/resources/vendors/@coreui/icons/svg/free.svg#cil-arrow-bottom"></use>
                        </svg>)</span></div>
                    <div data-coreui-i18n="users">Users</div>
                  </div>
                </div>
                <div class="c-chart-wrapper mt-3 mx-3" style="height:70px;">
                  <canvas class="chart" id="card-chart1" height="70"></canvas>
                </div>
              </div>
            </div>
            <!-- /.col-->
            <div class="col-sm-6 col-xl-3">
              <div class="card text-white bg-info-gradient">
                <div class="card-body pb-0 d-flex justify-content-between align-items-start">
                  <div>
                    <div class="fs-4 fw-semibold">$6.200 <span class="fs-6 fw-normal">(40.9%
                        <svg class="icon">
                          <use xlink:href="/resources/vendors/@coreui/icons/svg/free.svg#cil-arrow-top"></use>
                        </svg>)</span></div>
                    <div data-coreui-i18n="income">Income</div>
                  </div>
                </div>
                <div class="c-chart-wrapper mt-3 mx-3" style="height:70px;">
                  <canvas class="chart" id="card-chart2" height="70"></canvas>
                </div>
              </div>
            </div>
            <!-- /.col-->
            <div class="col-sm-6 col-xl-3">
              <div class="card text-white bg-warning-gradient">
                <div class="card-body pb-0 d-flex justify-content-between align-items-start">
                  <div>
                    <div class="fs-4 fw-semibold">2.49% <span class="fs-6 fw-normal">(84.7%
                        <svg class="icon">
                          <use xlink:href="/resources/vendors/@coreui/icons/svg/free.svg#cil-arrow-top"></use>
                        </svg>)</span></div>
                    <div data-coreui-i18n="conversionRate">Conversion Rate</div>
                  </div>
                </div>
                <div class="c-chart-wrapper mt-3" style="height:70px;">
                  <canvas class="chart" id="card-chart3" height="70"></canvas>
                </div>
              </div>
            </div>
            <!-- /.col-->
            <div class="col-sm-6 col-xl-3">
              <div class="card text-white bg-danger-gradient">
                <div class="card-body pb-0 d-flex justify-content-between align-items-start">
                  <div>
                    <div class="fs-4 fw-semibold">44K <span class="fs-6 fw-normal">(-23.6%
                        <svg class="icon">
                          <use xlink:href="/resources/vendors/@coreui/icons/svg/free.svg#cil-arrow-bottom"></use>
                        </svg>)</span></div>
                    <div data-coreui-i18n="sessions">Sessions</div>
                  </div>
                </div>
                <div class="c-chart-wrapper mt-3 mx-3" style="height:70px;">
                  <canvas class="chart" id="card-chart4" height="70"></canvas>
                </div>
              </div>
            </div>
            <!-- /.col-->
          </div>
          <!-- /.row-->
          <div class="card mb-4">
            <div class="card-body">
              <div class="d-flex justify-content-between">
                <div>
                  <h4 class="card-title mb-0" data-coreui-i18n="traffic">Traffic</h4>
                  <div class="small text-body-secondary"><span data-coreui-i18n-date="dateOnlyMonthName, { date: '2023, 1, 1'}">January</span> - <span data-coreui-i18n-date="dateOnlyMonthName, { 'date': '2023, 6, 30'}">July</span> 2023</div>
                </div>
                <div class="btn-toolbar d-none d-md-block" role="toolbar" aria-label="Toolbar with buttons">
                  <div class="btn-group btn-group-toggle mx-3" data-coreui-toggle="buttons">
                    <input class="btn-check" id="option1" type="radio" name="options" autocomplete="off">
                    <label class="btn btn-outline-secondary" data-coreui-i18n="day">Day</label>
                    <input class="btn-check" id="option2" type="radio" name="options" autocomplete="off" checked="">
                    <label class="btn btn-outline-secondary active" data-coreui-i18n="month">Month</label>
                    <input class="btn-check" id="option3" type="radio" name="options" autocomplete="off">
                    <label class="btn btn-outline-secondary" data-coreui-i18n="year">Year</label>
                  </div>
                  <button class="btn btn-primary" type="button">
                    <svg class="icon">
                      <use xlink:href="/resources/vendors/@coreui/icons/svg/free.svg#cil-cloud-download"></use>
                    </svg>
                  </button>
                </div>
              </div>
              <div class="c-chart-wrapper" style="height:300px;margin-top:40px;">
                <canvas class="chart" id="main-chart" height="300"></canvas>
              </div>
            </div>
            <div class="card-footer">
              <div class="row row-cols-1 row-cols-sm-2 row-cols-lg-4 row-cols-xl-5 g-4 mb-2 text-center">
                <div class="col">
                  <div class="text-body-secondary" data-coreui-i18n="visits">Visits</div>
                  <div class="fw-semibold text-truncate"><span data-coreui-i18n="usersCounter, { 'counter': '29.703' }">29.703 Users</span> (40%)</div>
                  <div class="progress progress-thin mt-2">
                    <div class="progress-bar bg-success-gradient" role="progressbar" style="width: 40%" aria-valuenow="40" aria-valuemin="0" aria-valuemax="100"></div>
                  </div>
                </div>
                <div class="col">
                  <div class="text-body-secondary" data-coreui-i18n="unique">Unique</div>
                  <div class="fw-semibold text-truncate"><span data-coreui-i18n="usersCounter, { 'counter': '24.093' }">24.093 Users</span> (20%)</div>
                  <div class="progress progress-thin mt-2">
                    <div class="progress-bar bg-info-gradient" role="progressbar" style="width: 20%" aria-valuenow="20" aria-valuemin="0" aria-valuemax="100"></div>
                  </div>
                </div>
                <div class="col">
                  <div class="text-body-secondary" data-coreui-i18n="pageviews">Pageviews</div>
                  <div class="fw-semibold text-truncate"><span data-coreui-i18n="viewsCounter, { 'counter': '78.706' }">78.706 Views</span> (60%)</div>
                  <div class="progress progress-thin mt-2">
                    <div class="progress-bar bg-warning-gradient" role="progressbar" style="width: 60%" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100"></div>
                  </div>
                </div>
                <div class="col">
                  <div class="text-body-secondary" data-coreui-i18n="newUsers">New Users</div>
                  <div class="fw-semibold text-truncate"><span data-coreui-i18n="usersCounter, { 'counter': '22.123' }">22.123 Users</span>(80%)</div>
                  <div class="progress progress-thin mt-2">
                    <div class="progress-bar bg-danger-gradient" role="progressbar" style="width: 80%" aria-valuenow="80" aria-valuemin="0" aria-valuemax="100"></div>
                  </div>
                </div>
                <div class="col d-none d-xl-block">
                  <div class="text-body-secondary" data-coreui-i18n="bounceRate">Bounce Rate</div>
                  <div class="fw-semibold text-truncate">40.15%</div>
                  <div class="progress progress-thin mt-2">
                    <div class="progress-bar" role="progressbar" style="width: 40%" aria-valuenow="40" aria-valuemin="0" aria-valuemax="100"></div>
                  </div>
                </div>
              </div>
            </div>
          </div>
          <!-- /.card.mb-4-->
        </div>
      </div>
      
<%@ include file="../include/footer.jsp" %>
  </body>
</html>