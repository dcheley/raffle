var Transactions = React.createClass({
  getInitialState() {
    return {
      transactions: this.props.transactions,
      transaction: {
        payee: '',
        email: '',
        status: 2
      },
      errors: {}
    }
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
    this.setState({transaction: newTransaction});
  },

  handleConfirmation() {
    var that = this;
    $.ajax({
      method: 'POST',
      data: {
        transaction: that.state.transaction,
      },
      url: '/transactions.json'
      success: function(res) {
        var newTransactionList.push(res);
        that.setState({
          transactions: newTransactionList,
          transaction: {
            payee: '',
            email: '',
            status: 3
          },
          errors: {}
        });
      }
    });
  },

  render() {
    transactions = this.props.transactions.map( function(transaction) {
      return (
        <Transaction transaction={transaction} key={transaction.id} />
      );
    });
    return (
      <div>
        <h1>Transactions</h1>
        <div id="transactions">
          <table>
            <thead>
              <tr>
                <th>Payee Name</th>
                <th>Email</th>
                <th>Status</th>
              </tr>
            </thead>
            <tbody>
              {transactions}
              <tr>
                <td>
                  <input type="text" value={this.state.transaction.payee} onChange={this.handlePayeeChange} /><br />
                  <span style={{color: 'red'}}>{this.state.errors.payee}</span>
                </td>
                <td>
                  <input value={this.state.transaction.email} type="text" onChange={this.handleEmailChange} /><br />
                  <span style={{color: 'red'}}>{this.state.errors.email}</span>
                </td>
                <td><input value={this.state.transaction.status} type="checkbox" onChange={this.handleStatusChange} /></td>
                <td><button onClick={this.handleConfirmation}>Confirm</button></td>
              </tr>
            </tbody>
          </table>
        </div>
      </div>
    );
  }
});
