import { Space, Table, Tag } from 'antd';

export const columns = [
  {
    title: 'idFilme',
    dataIndex: 'idFilme',
    key: 'idFilme',
    render: (text) => <a>{text}</a>,
    sortOrder: 'descend'
  },
  {
    title: 'titulo',
    dataIndex: 'titulo',
    key: 'titulo',
  },
  {
    title: 'imdbCode',
    dataIndex: 'imdbCode',
    key: 'imdbCode',
  },
  {
    title: 'anoLancamento',
    key: 'anoLancamento',
    dataIndex: 'anoLancamento',
  },
  {
    title: 'Action',
    key: 'action',
    render: () => (
      <Space size="middle">
        <a>update</a>
        <a>Delete</a>
      </Space>
    ),
  },
];
// const data = [
//   {
//     key: '1',
//     name: 'John Brown',
//     age: 32,
//     address: 'New York No. 1 Lake Park',
//     tags: ['nice', 'developer'],
//   },
//   {
//     key: '2',
//     name: 'Jim Green',
//     age: 42,
//     address: 'London No. 1 Lake Park',
//     tags: ['loser'],
//   },
//   {
//     key: '3',
//     name: 'Joe Black',
//     age: 32,
//     address: 'Sydney No. 1 Lake Park',
//     tags: ['cool', 'teacher'],
//   },
// ];
// const App = () => <Table columns={columns} dataSource={data} />;
// export default App;