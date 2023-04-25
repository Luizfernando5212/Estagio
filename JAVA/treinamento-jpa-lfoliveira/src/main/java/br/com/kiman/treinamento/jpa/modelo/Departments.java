package br.com.kiman.treinamento.jpa.modelo;

import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.SequenceGenerator;

@Entity
public class Departments {
	
	@Id @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "departments_seq")
	@SequenceGenerator(name="departments_seq", sequenceName="departments_seq")
	@Column(name="department_id")
	private int departmentId;
	
	@OneToMany(mappedBy="departmentId")
	Set<Employees> employees;
	
	@Column(name="department_name")
	private String departmentName;
	
	@Column(name="manager_id")
	private int managerId;
	
	@Column(name="location_id")
	private int locationId;

	public int getDepartmentId() {
		return departmentId;
	}

	public void setDepartmentId(int departmentId) {
		this.departmentId = departmentId;
	}

	public String getDepartmentName() {
		return departmentName;
	}

	public void setDepartmentName(String departmentName) {
		this.departmentName = departmentName;
	}

	public int getManagerId() {
		return managerId;
	}

	public void setManagerId(int managerId) {
		this.managerId = managerId;
	}

	public int getLocationId() {
		return locationId;
	}

	public void setLocationId(int locationId) {
		this.locationId = locationId;
	}
	

}
