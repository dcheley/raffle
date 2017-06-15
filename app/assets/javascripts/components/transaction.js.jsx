var Transaction = React.createClass({
  getInitialState() {
    return {
      transaction: this.props.transaction,
      editMode: false,
      errors: {}
    }
  },

  setEditMode() {
    this.setState({editMode: true});
  },

  handlePayeeChange(e) {
    var newTransaction = this.state.transaction;
    newTransaction.payee = e.target.value;
    this.setState({transaction: newTransaction});
  },

  handleEmailChange(e) {
    var newTransaction = this.state.transaction;
    newTransaction.email = e.target.value;
    this.setState({transaction: newTransaction});
  },

  handleStatusChange(e) {
    var newTransaction = this.state.transaction;
    newTransaction.status = e.target.value;
    this.setState({tansaction: newTransaction});
  },

  toggleStatusChange() {
    var newTransaction = this.state.transaction;
    newTransaction.status = !this.state.transaction.status;
    this.setState({transaction: newTransaction});
    this.handleTransactionUpdate();
  },

  handleTransactionUpdate() {
    var that = this;
    $.ajax({
      method: 'PUT',
      data: {
        transaction: that.state.transaction,
      },
      url: '/transactions/' + that.state.transaction.id + '.json',
      success: function(res) {
        that.setState({
          errors: {},
          transaction: res,
          editMode: false
        });
      },
      error: function(res) {
        that.setState({errors: res.responseJSON.errors});
      }
    });
  },

  render() {
    if ( this.state.editMode ) {
      markup = (
        <tr>
          <td>
            <input
              type="text"
              value={this.state.transaction.payee}
              onChange={this.handlePayeeChange} />
            <span style={{color: 'red'}}>{this.state.errors.payee}</span>
          </td>
          <td>
            <input
              type="text"
              value={this.state.transaction.email}
              onChange={this.handleEmailChange} />
            <br />
            <span style={{color: 'red'}}>{this.state.errors.email}</span>
          </td>
          <td>
            <input
              type="checkbox"
              value={this.state.transaction.status}
              onChange={this.handleStatusChange} />
          </td>
          <td>
            <button onClick={this.handleTransactionUpdate}>Save</button>
          </td>
        </tr>
      );
    } else {
      markup = (
        <tr>
          <td>{this.state.transaction.payee}</td>
          <td>{this.state.transaction.email}</td>
          <td>{this.state.transaction.status ? '1' : '2'}</td>
          <td>
            <button onClick={this.setEditMode}>Edit</button>
            <button onClick={this.toggleStatusChange}>{this.state.transaction.status ? 'Reject' : 'Confirm'}</button>
          </td>
        </tr>
      );
    }
    return markup;
  }
});
