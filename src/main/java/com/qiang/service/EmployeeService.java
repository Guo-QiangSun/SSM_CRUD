package com.qiang.service;

import com.qiang.bean.Employee;
import com.qiang.dao.EmployeeMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
public class EmployeeService {
    /**
     * service层调用deo层
     */
    @Autowired
    EmployeeMapper employeeMapper;

    /**
     * 查询所有员工
     * @return
     */
    public List<Employee> getAllEmployee(){
        return employeeMapper.selectByExampleWithDept(null);
    }
}
