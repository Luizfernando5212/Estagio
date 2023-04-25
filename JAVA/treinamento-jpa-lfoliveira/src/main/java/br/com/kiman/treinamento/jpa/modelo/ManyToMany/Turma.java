package br.com.kiman.treinamento.jpa.modelo.ManyToMany;

import java.util.Set;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.ManyToMany;

@Entity
public class Turma {
	
	@Id @GeneratedValue
	private int id;
	
	@ManyToMany
	private Set<Aluno> alunos;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public Set<Aluno> getAlunos() {
		return alunos;
	}

	public void setAlunos(Set<Aluno> alunos) {
		this.alunos = alunos;
	}
	
	public void addAluno(Aluno aluno) {
		alunos.add(aluno);
		aluno.matricular(this);
	}
}
