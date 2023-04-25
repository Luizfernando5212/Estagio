import './App.css';
import React, { useEffect, useState } from 'react';
import Tabela from './Table.js';
// import MeuLay from './customize';
import { Button, Input } from 'antd';


function ApiData() {
  const [data, setData] = useState([]);
  const [refresh, setRefresh] = useState(true);
  const [isSorted, setIsSorted] = useState(false);
  const [idFilter, setIdFilter] = useState('');
  const [tituloFilter, setTituloFilter] = useState('');
  const [show, setShow] = useState(true)

  // const [consulta, setConsulta] = useState([]);

  useEffect(() => {
    let url = 'http://localhost:8080/treinamento-jpa-lfoliveira/webapi/filmes'
    fetch(url)
      .then(response => response.json())
      .then(data => {
        console.log(data);
        setData([...data].sort((a, b) => b.idFilme - a.idFilme))
      });
      // console.log(data)
  }, [refresh]);

  // useEffect(() => {

  //   const queryParams = {}

  //   if (tituloFilter) {
  //     queryParams.titulo = encodeURIComponent(tituloFilter)
  //   }
  //   if (idFilter) {
  //     queryParams.id = encodeURIComponent(idFilter)
  //   }

  //   const urlSearchParams = new URLSearchParams(queryParams);

  //   let url = `http://localhost:8080/treinamento-jpa-lfoliveira/webapi/filmes/title?${urlSearchParams.toString()}`

  //   let timeout = setTimeout(() => {
  //     fetch(url)
  //     .then(response => response.json())
  //     .then(data => setConsulta(data));
  //   }, 500)
  //   return () => {
  //       clearTimeout(timeout)
  //     }
  // }, [idFilter, tituloFilter])

  const handleClean = () => {
    setData([]);
    console.log(data.length)
  }

  const handleRefresh = () => {
    handleClean()
    setRefresh(!refresh);
  }

  const handleSort = () => {
    setIsSorted(!isSorted)
    setData( oldData => {
      const newData = [...oldData];
      newData.sort((a, b) => (!isSorted ? a.idFilme - b.idFilme : b.idFilme - a.idFilme))
      return newData
    });
  }

  const handleIdInput = (event) => {
    setIdFilter(event.target.value)
  }

  const handleTituloInput = (event) => {
    setTituloFilter(event.target.value)
  }

  return (
    <div>
      <div id='main'>
        <Button onClick={handleClean} className='btn' disabled={!(data.length !== 0)}>Limpar</Button>
        <Button onClick={handleRefresh} className='btn'>atualizar</Button>
        <Button onClick={handleSort} className='btn' disabled={!(data.length !== 0)}>{!isSorted ? 'Ordenar por ID crescente' : 'Ordenar por ID decrescente'}</Button><br/>
      </div>
      <div style={{width: '30%', display: 'flex'}}>
        <Input id='idFilter' value={idFilter} onChange={handleIdInput} placeholder='Filtro por ID' /* style={{width: '10px'}} */ className='input-css'/>
        <Input id='tituloFilter' value={tituloFilter} onChange={handleTituloInput} placeholder='Filtro por Titulo' className='input-css'/>
      </div>
      <h1>Filmes</h1>
      <div style={{width: '50%'}}>


        <Tabela show={{ set: setShow, get: show}} refresh={handleRefresh} filters={[idFilter, tituloFilter]} data={data} />



        {show && <InputFilme refresh={handleRefresh}/>}
      </div>
    </div>
  );
}

function InputFilme(props) {
  const [filme, setFilme] = useState({
    idFilme: '',
    titulo: '',
    imdbCode: '',
    anoLancamento: ''
  });

  const handleSubmit = (event) => {
    let url = 'http://localhost:8080/treinamento-jpa-lfoliveira/webapi/filmes'
    event.preventDefault();

    // const formData = new FormData(event.target);
    // const formValues = Object.fromEntries(formData.entries());

    console.log(filme)
    // console.log(formValues)
  // Cria um objeto de opções para o fetch
    const options = {
      method: 'POST',
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
        console.log('Formulário enviado com sucesso!');
      } else {
        throw new Error('Erro ao enviar formulário.');
      }
    })
    .catch(error => {
      console.error(error)
    })
    .finally(() => {
      props.refresh();
      setFilme (() => {
        
       return { 
        idFilme: '',
        titulo: '',
        imdbCode: '',
        anoLancamento: ''
        }
    })
    });
    
  }
  
  const handleInputChange = (event) => {
    const { name, value } = event.target;

    setFilme(filme => ({
      ...filme,
      [name]: value
    }));
  }

  return (
    // <tr>
    //   <td  colSpan='4'>
        <form onSubmit={handleSubmit} style={{width: '100%'}}>
          <input name='idFilme' type='number' value={filme.idFilme} onChange={handleInputChange} style={{width: '11%'}}/>
          <input name='titulo' type='text' value={filme.titulo} onChange={handleInputChange} style={{width: '29.5%'}}/>
          <input name='imdbCode' type='text' value={filme.imdbCode} onChange={handleInputChange} style={{width: '11%'}}/>
          <input name='anoLancamento' type='text' value={filme.anoLancamento} onChange={handleInputChange} style={{width: '19.5%'}}/>
          <button type='submit' style={{width: '15%'}}>Submit</button>
        </form>
    //   </td>
    // </tr>
  )
}

// consulta={consulta}
export function App() {
  return (
    <div>
      <h1>Dados da ApiData</h1>
      {/* <MeuLay /> */}
      <ApiData />
    </div>
  )
}
