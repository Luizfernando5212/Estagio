import React, { useState } from 'react';
import { Button } from 'antd';
import { Table } from 'antd'
import { columns } from './customize';

export function Tabela(props) {
    // const [show, setShow] = useState(true)
    const [updFilme, setUpdFilme] = useState({
      idFilme: '',
      titulo: '',
      imdbCode: '',
      anoLancamento: ''
    })
    
    // const idLine = (id) => {
    //   let verifica = false
    //   for (let filme of props.consulta) {
    //     verifica = filme.idFilme === id
    //     if (verifica) {
    //       return verifica
    //     }
    //   }
    // }
    // let tableTeste = props.data.map(filme => (
    //   <tr key={filme.idFilme} className={verifyId(filme.idFilme) || verifyTitle(filme.titulo) ? 'linha' : ''}>
    //     <td className={verifyId(filme.idFilme) ? 'teste' : ''}>{filme.idFilme}</td>
    //     <td className={verifyTitle(filme.titulo) ? 'teste' : ''}>{filme.titulo}</td>
    //     <td>{filme.imdbCode}</td>
    //     <td>{filme.anoLancamento}</td>
    //     <td><button onClick={() => handleDelete(filme.idFilme)}>Deletar</button></td>
    //     <td><button onClick={() => handleUpdate(filme)}>Atualizar</button></td>
    //   </tr>
    // ))
  
    const verifyId = (id) => {
      
      if (props.filters[0]) {
        const searchTerm = `^${props.filters[0]}`;
        const regex = new RegExp(searchTerm);
        return regex.test(id);
      }
      return false
    }
  
    const verifyTitle = (title) => {
      if (props.filters[1]) {
        const searchTerm = `^${props.filters[1]}`;
        const regex = new RegExp(searchTerm);
        return regex.test(title);
      }
      return false
    }
  
    const handleDelete = (id) => {
      let url = `http://localhost:8080/treinamento-jpa-lfoliveira/webapi/filmes/${id}`
      
      const options = {
        method: 'DELETE',
      };
      fetch(url, options)
        .then(response => {
          if (response.ok) {
            // Trata a resposta do servidor
            console.log('Cadastro deletado!');
          } else {
            throw new Error('Erro ao deletar cadastro.');
          }
        })
        .catch(error => {
          console.error(error)
        })
        .finally(() => props.refresh())
    }
  
    const handleUpdate = (filme) => {    
      if (props.show.get) {
        setUpdFilme(filme);
        props.show.set(!props.show.get);
        console.log(filme);
      } else {
        let url = `http://localhost:8080/treinamento-jpa-lfoliveira/webapi/filmes/${filme.idFilme}`
  
      const options = {
        method: 'PUT',
        // mode: 'no-cors',
        body: JSON.stringify(filme),
        headers: {
          'Content-Type': 'application/json'
        }
      };
  
      fetch(url, options)
        .then(response => {
          if (response.ok) {
            // Trata a resposta do servidor
            console.log('Dado atualizado com sucesso!');
          } else {
            throw new Error('Erro ao atualizar dado.');
          }
        })
        .catch(error => {
          console.error(error)
        })
        .finally(() => {
          props.refresh();
          setUpdFilme (() => {
            
           return { 
            idFilme: '',
            titulo: '',
            imdbCode: '',
            anoLancamento: ''
            }
        })
        props.show.set(!props.show.get);
        });
      }
    }
  
    const handleInputChange = (event) => {
      const { name, value } = event.target;
  
      setUpdFilme(filme => ({
        ...filme,
        [name]: value
      }));
    }
  
    return (

      // <Table columns={columns} pagination={false} dataSource={props.data} />

      <table className='table-round-corner' style={{width: '90%'}}>
        <thead>
          <tr>
            <th style={{width: '15%'}}>idFilme</th>
            <th style={{width: '45%'}}>Título</th>
            <th style={{width: '15%'}}>imdbCode</th>
            <th style={{width: '25%'}}>Ano_lançamento</th>
          </tr>
        </thead>
        <tbody> {props.show.get ? 
          props.data.map(filme => (
            <tr key={filme.idFilme} className={verifyId(filme.idFilme) || verifyTitle(filme.titulo) ? 'linha' : ''}>
              <td className={verifyId(filme.idFilme) ? 'teste' : ''}>{filme.idFilme}</td>
              <td className={verifyTitle(filme.titulo) ? 'teste' : ''}>{filme.titulo}</td>
              <td>{filme.imdbCode}</td>
              <td>{filme.anoLancamento}</td>
              <td><Button danger onClick={() => handleDelete(filme.idFilme)}>Deletar</Button></td>
              <td><Button onClick={() => handleUpdate(filme)}>Atualizar</Button></td>
            </tr>
          )) :
            <tr key={updFilme.idFilme}>
              <td>{updFilme.idFilme}</td>
              <td><input name='titulo' type='text' value={updFilme.titulo} onChange={handleInputChange} placeholder={updFilme.titulo} class='input-allign'/></td>
              <td>{updFilme.imdbCode}</td>
              <td><input name='anoLancamento' type='text' value={updFilme.anoLancamento} onChange={handleInputChange} placeholder={updFilme.anoLancamento} class='input-allign'/></td>
              <td><button onClick={() => handleUpdate(updFilme)}>Atualizar</button></td>
            </tr> }
        </tbody>
      </table>
    )
  }

  export default Tabela;