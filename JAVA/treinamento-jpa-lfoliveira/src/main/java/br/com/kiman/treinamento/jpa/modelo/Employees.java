package br.com.kiman.treinamento.jpa.modelo;

import java.sql.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.SequenceGenerator;

@Entity
public class Employees {
	
	@Id 
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator="EMPLOYEES_SEQ")
	@SequenceGenerator(name="EMPLOYEES_SEQ", sequenceName="EMPLOYEES_SEQ")
	@Column(name="employee_id")
	private int employeeId;
	
	@Column(name="first_name")
	private String firstName;
	
	@Column(name="last_name")
	private String lastName;
	
	private String email;
	
	@Column(name="phone_number")
	private String phoneNumber;
	
	@Column(name="hire_date")
	private Date hireDate;
	
	@Column(name="job_id")
	private String jobId;
	
	private Double salary;
	
	@Column(name="commission_pct")
	private Double commissionPct;
	
//	@JoinColumn(name="manager_id", referencedColumnName="employee_id")
	@Column(name="manager_id")
	private String managerId;
	
	@ManyToOne
	@JoinColumn(name="department_id", referencedColumnName = "department_id")
	private Departments departmentId;

	
	public int getEmployeeId() {
		return employeeId;
	}

	public void setEmployeeId(int employeeId) {
		this.employeeId = employeeId;
	}

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPhoneNumber() {
		return phoneNumber;
	}

	public void setPhoneNumber(String phoneNumber) {
		this.phoneNumber = phoneNumber;
	}

	public Date getHireDate() {
		return hireDate;
	}

	public void setHireDate(Date hireDate) {
		this.hireDate = hireDate;
	}

	public String getJobId() {
		return jobId;
	}

	public void setJobId(String jobId) {
		this.jobId = jobId;
	}

	public Double getSalary() {
		return salary;
	}

	public void setSalary(Double salary) {
		this.salary = salary;
	}

	public Double getCommissionPct() {
		return commissionPct;
	}

	public void setCommissionPct(Double commissionPct) {
		this.commissionPct = commissionPct;
	}

	public String getManagerId() {
		return managerId;
	}

	public void setManagerId(String managerId) {
		this.managerId = managerId;
	}

	public Departments getDepartmentId() {
		return departmentId;
	}

	public void setDepartmentId(Departments departmentId) {
		this.departmentId = departmentId;
	}

	
}
