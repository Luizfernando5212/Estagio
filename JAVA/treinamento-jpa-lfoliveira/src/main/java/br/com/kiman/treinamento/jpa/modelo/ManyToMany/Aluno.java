package br.com.kiman.treinamento.jpa.modelo.ManyToMany;

import java.util.Set;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.ManyToMany;

@Entity
public class Aluno {
	
	@Id @GeneratedValue
	private int id;
	
	@ManyToMany(mappedBy = "alunos")
	private Set<Turma> turmas;
	
	private String nome;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public Set<Turma> getTurmas() {
		return turmas;
	}

	public void setTurmas(Set<Turma> turmas) {
		this.turmas = turmas;
	}
	
	public void matricular(Turma turma) {
		turmas.add(turma);
		turma.addAluno(this);
	}
	
	public String getNome() {
		return nome;
	}

	public void setNome(String nome) {
		this.nome = nome;
	}
	
}
