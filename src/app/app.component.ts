import {Component} from '@angular/core';
import {canBeNumber} from '../util/validation';


@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css']
})
export class AppComponent {
  items = ["Angularjs", "Reactjs", "Vuejs"];

  newItem = "";

  addItem = function() {
    if(this.newItem != "") {
      this.items.push(this.newItem);
      this.newItem = "";
    }
    
  }

  deleteItem = function(index) {
    this.items.splice(index, 1);
  }
}