var Transactions = React.createClass({
  getInitialState() {
    return {
      transactions: this.props.transactions,
      transaction: {
        name: '',
        email: '',
        status: 2
      },
      errors: {}
    }
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
                <th>Name</th>
                <th>Email</th>
                <th>Status</th>
              </tr>
            </thead>
            <tbody>
              {transactions}
              <tr>
                <td>
                  <input type="text" value={this.state.transaction.name} onChange={this.handleNameChange} /><br />
                  <span style={{color: 'red'}}>{this.state.errors.name}</span>
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
