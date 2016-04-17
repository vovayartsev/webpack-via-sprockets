//= depend_on ./components/my_form_component.js
//= webpack webpack.config.js

import React from 'react';
import ReactDOM from 'react-dom';

import { createStore, combineReducers } from 'redux';
import { Provider } from 'react-redux';
import { modelReducer, formReducer } from 'react-redux-form';


import MyForm from './components/my_form_component.js';


const store = createStore(combineReducers({
  user: modelReducer('user', { name: '' }),
  userForm: formReducer('user')
}));

export default class App extends React.Component {
  render() {
    return (
      <Provider store={ store }>
        <MyForm />
      </Provider>
    );
  }
}

ReactDOM.render(<App/>, document.getElementById('app'));
