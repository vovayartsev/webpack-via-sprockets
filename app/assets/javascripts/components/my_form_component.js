import React from 'react';
import { connect } from 'react-redux';
import { Field } from 'react-redux-form';

let FieldWithLabel = function (props) {
  const {model, label} = props;
  return (
    <div>
      <label for={model}>{label}</label>
      <Field model={model}>
        <input type="text" />
      </Field>
    </div>
  );
};


class MyForm extends React.Component {
  render() {
    let { user } = this.props;

    return (
      <form onSubmit={ e => this.handleSubmit(e) }>
        <h1>Hello, { user.name }!</h1>
        <FieldWithLabel model="user.name" label="Your name: "/>
        <FieldWithLabel model="user.email" label="E-mail: "/>
        <button type="submit">Send it!</button>
      </form>
    );
  }

  handleSubmit(event) {
    event.preventDefault();
    window.alert(`Submitting ${this.props.user.name}`);
  }
}

export default connect(state => ({user: state.user}))(MyForm);
