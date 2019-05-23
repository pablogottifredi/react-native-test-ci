import React, { Component } from 'react';
import { View, Text, StyleSheet, Button } from 'react-native';

class HomeView extends Component {
    render() {
        return (
            <View style={styles.container}>
                <Text style={styles.text}>
                    Hola nanita, te saludo soy una app
                    Estoy adentro de un emulador
                </Text>

                <Button 
                    onPress={()=> this.props.navigation.navigate('Landing')} 
                    style={styles.button} 
                    title="Ok Go" />
            </View>
        );
    }
}

export default HomeView



const styles = StyleSheet.create({
    container: {
        backgroundColor: 'green',
        flex:1,
        padding: 10
    },
    text: {
        paddingBottom: 14,
        color: '#fff',
        fontSize: 24
    },
    button:{
        backgroundColor: 'red',
        height:70,
        flexDirection: 'row',
        justifyContent: 'center',
        alignItems: 'center'
    }
});

