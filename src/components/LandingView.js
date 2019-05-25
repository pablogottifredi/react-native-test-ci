import React, { Component } from 'react';
import { View, Text, TouchableHighlight, StyleSheet, Button } from 'react-native';

class LandingView extends Component {
    render() {
        return (
            <View style={styles.container}>
                <Text style={styles.text}>
                    Landing View
                </Text>
                <TouchableHighlight style={styles.button}
                    onPress={()=> this.props.navigation.navigate('ExternalDoc')}>
                    <Text style={styles.button_text}>
                        Go To External Navigator
                    </Text>
                </TouchableHighlight>

            </View>
        );
    }
}

export default LandingView

const styles = StyleSheet.create({
    container: {
        flex:1,
        backgroundColor: 'red',
        padding: 10
    },
    text: {
        paddingBottom: 14,
        color: '#fff',
        fontSize: 24
    },
    button:{
        backgroundColor: 'transparent',
        borderRadius:2,
        borderWidth: 1,
        borderColor: '#fff',
        height:40,
        alignContent: 'center',
        alignItems: 'center'
       
    },
    button_text: {
        fontSize: 16,
        textAlign: 'center',
        textAlignVertical: 'center',
        height: 40
    }
});
