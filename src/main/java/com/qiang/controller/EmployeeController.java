package com.qiang.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.qiang.bean.Employee;
import com.qiang.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * 处理员工的CRUD
 */
@Controller
public class EmployeeController {
    /**
     * Controller层调service层
     * 查询员工数据（分页查询）
     *
     * @return
     */
    @Autowired
    EmployeeService employeeService;
    //@ResponseBody可以直接将返回值转换为json字符串,需要导入jackson
    @ResponseBody
    @RequestMapping("/emps")
    public PageInfo getEmpsWithJson(@RequestParam(value = "pn", defaultValue = "1") Integer pn){
        /*
         * 在查询之前调用PageHelper，传入页面，和每页要显示的页数
         * 紧跟的查询就是一个分页查询
         */
        PageHelper.startPage(pn, 5);
        List<Employee> allEmployee = employeeService.getAllEmployee();

        // 使用PageInfo包装查询的信息，封装了页面详细信息,连续显示5页
        PageInfo pageInfo = new PageInfo(allEmployee, 5);
         return  pageInfo;
    }

    //@RequestMapping("/emps")
    public String getEmps(@RequestParam(value = "pn", defaultValue = "1") Integer pn, Model model) {
        /*
         * 在查询之前调用PageHelper，传入页面，和每页要显示的页数
         * 紧跟的查询就是一个分页查询
         */
        PageHelper.startPage(pn, 5);
        List<Employee> allEmployee = employeeService.getAllEmployee();

        // 使用PageInfo包装查询的信息，封装了页面详细信息,连续显示5页
        PageInfo pageInfo = new PageInfo(allEmployee, 5);

        //用model保存请求域信息
        model.addAttribute("pageInfo", pageInfo);

        return "employeeList";
    }

}
