<%--
  Created by IntelliJ IDEA.
  User: 21915
  Date: 2022/5/15
  Time: 14:00
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>员工信息</title>
    <%
        pageContext.setAttribute("APP_PATH", request.getContextPath());
    %>
    <%--引入jQuary--%>
    <script type="text/javascript" src="${APP_PATH}/static/js/jquery-3.6.0.min.js"></script>
    <%--引入bootstrap样式--%>
    <link rel="stylesheet" href="${APP_PATH}/static/bootstrap/css/bootstrap.min.css">
    <script src="${APP_PATH}/static/bootstrap/js/bootstrap.min.js"></script>
</head>
<body>
<%--显示页面--%>
<div class="container">
    <%--标题--%>
    <div class="row">
        <div class="col-md-12">
            <h1>SSM_CRUD</h1>
        </div>
    </div>
    <%--按钮--%>
    <div class="row">
        <div class="col-md-4 col-md-offset-8">
            <button class="btn btn-primary btn-sm">增加</button>
            <button class="btn btn-danger btn-sm">删除</button>
        </div>
    </div>
    <%--表格--%>
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover" id="emps_table">
                <thead>
                <tr>
                    <th>员工号</th>
                    <th>姓名</th>
                    <th>性别</th>
                    <th>电子邮件</th>
                    <th>部门</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody></tbody>
            </table>
        </div>
    </div>
    <%--分页信息--%>
    <div class="row">
        <%--分页文字信息--%>
        <div class="col-md-6" id="page_info"></div>
        <%--分页条信息--%>
        <div class="col-md-6" id="page_nav"></div>
    </div>
</div>
<script type="text/javascript">
    //页面加载完成，直接发送AJAX请求，要到分页数据
    $(function () {
      to_page(1);
    });
    function to_page(pn){
        $.ajax({
            url: "${APP_PATH}/emps",
            data: "pn="+pn,
            type: "GET",
            //result就是服务器返回的结果
            success: function (result) {
               // console.log(result);
                //解析并显示数据
                build_emps_table(result);
                build_emps_info(result);
                build_emps_nav(result);
            }
        });
    }
    //解析显示表格数据
    function build_emps_table(result) {
        $("#emps_table tbody").empty();
        var emps = result.map.Info.list;
        //遍历拿到的数据
        $.each(emps, function (index, item) {
            var empIdTd = $("<td></td>").append(item.empId);
            var empNameTd = $("<td></td>").append(item.empName);
            var genderTd = $("<td></td>").append(item.gender);
            var emailTd = $("<td></td>").append(item.email);
            var deptNameTd = $("<td></td>").append(item.department.deptName);
            var editBtn = $("<button></button>").addClass("btn btn-primary btn-sm")
                .append($("<span></span>").addClass("glyphicon glyphicon-pencil"))
                .append("编辑");
            var delBtn = $("<button></button>").addClass("btn btn-danger btn-sm")
                .append($("<span></span>").addClass("glyphicon glyphicon-trash"))
                .append("删除");
            var btnTd=$("<td></td>").append(editBtn).append(" ").append(delBtn);
            $("<tr></tr>").append(empIdTd)
                .append(empNameTd)
                .append(genderTd)
                .append(emailTd)
                .append(deptNameTd)
                .append(btnTd)
                .appendTo("#emps_table tbody");
        });
    }
    //解析显示分页信息
    function  build_emps_info(result){
        $("#page_info").empty();
      $("#page_info").append("当前第"+result.map.Info.pageNum+"页，共"
          +result.map.Info.pages+"页，总计"
          +result.map.Info.total+"记录");
    }
    //解析显示分页条信息
    function  build_emps_nav(result){
        $("#page_nav").empty();
        var  ul=$("<ul></ul>").addClass("pagination");
        var firstPageLi=$("<li></li>").append($("<a></a>").append("首页").attr("href","#"));
        var prePageLi=$("<li></li>").append($("<a></a>").append("&laquo;"));
        if(result.map.Info.hasPreviousPage==false){
            firstPageLi.addClass("disabled");
            prePageLi.addClass("disabled");
        }else{
            firstPageLi.click(function (){
                to_page(1);
            });
            prePageLi.click(function (){
                to_page(result.map.Info.pageNum-1);
            });
        }

        var nextPageLi=$("<li></li>").append($("<a></a>").append("&raquo;"));
        var lastPageLi=$("<li></li>").append($("<a></a>").append("末页").attr("href","#"));
        if(result.map.Info.hasNextPage==false){
            nextPageLi.addClass("disabled");
            lastPageLi.addClass("disabled");
        }else{
            nextPageLi.click(function (){
                to_page(result.map.Info.pageNum+1);
            });
            lastPageLi.click(function (){
                to_page(result.map.Info.pages);
            });
        }

        ul.append(firstPageLi).append(prePageLi);
        //遍历页码号
        $.each(result.map.Info.navigatepageNums,function (index,item){
            var numLi=$("<li></li>").append($("<a></a>").append(item));
            if(result.map.Info.pageNum==item){
                numLi.addClass("active");
            }
            numLi.click(function (){
                to_page(item);
            })
            ul.append(numLi)
        });
        ul.append(nextPageLi).append(lastPageLi);
        var nav=$("<nav></nav>").append(ul);
        nav.appendTo("#page_nav");
    }
</script>
</body>
</html>
