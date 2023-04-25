package br.com.kiman.curso.dominio.Bean;

import java.util.List;

import javax.ejb.Stateless;
import javax.inject.Inject;

import br.com.kiman.curso.dominio.Dao.ProdutoDao;
import br.com.kiman.curso.dominio.model.Produto;

@Stateless
public class ProdutoBean {
	
	@Inject
	ProdutoDao produtoDao;
	
	public List<Produto> findAll(){
		return produtoDao.findAll();
	}
	
	public Produto findById(Long id) {
		return produtoDao.findById(id);
	}
	
	public List<Produto> findByFilter(String descricao){
		if (descricao.equals("empty"))
			return this.findAll();
		return produtoDao.findByDescricao(descricao);
	}
	
	public void insertProduto(Produto produto) {
		if (produto.getDescricao().length() >= 3) {
			produtoDao.insert(produto);
		}
	}
	
	public void updateProduto(Long id, Produto produto) {
		if (produto.getDescricao().length() >= 3) {
			Produto oldProduto = produtoDao.findById(id);
			oldProduto.setDescricao(produto.getDescricao());
			produtoDao.update(oldProduto);
		}
	}
	
	public void deleteProduto(Long id) {
		produtoDao.delete(id);
	}
}
