import React, {Component} from 'react';
import {WebView} from 'react-native';

class ExternalDoc extends Component {
  render() {
    return (
      <WebView
        source={{uri: 'http://www.reddit.com'}}
        style={{marginTop: 20}}
      />
    );
  }
}

export default ExternalDoc
