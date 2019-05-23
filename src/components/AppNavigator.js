import { createAppContainer, createStackNavigator } from 'react-navigation';
import HomeView from './HomeView';
import LandingView from './LandingView';
import ExternalDoc from './ExternalDocView';
const AppNavigator = createStackNavigator({
  Home: { screen: HomeView },
  Landing: { screen: LandingView},
  ExternalDoc: { screen: ExternalDoc }
},
{
    initialRouteName: 'Home',
    headerMode: 'none'
});
const AppContainer = createAppContainer( AppNavigator );

export default AppContainer;