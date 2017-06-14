var Transaction = React.createClass({
  getInitialState() {
    return {
      transaction: this.props.transaction
    }
  },

  render() {
    return (
      <tr>
        <td>{this.state.transaction.name}</td>
        <td>{this.state.transaction.email}</td>
        <td>{this.state.transaction.status ? '1' : ''}</td>
      </tr>
    );
  }
});
