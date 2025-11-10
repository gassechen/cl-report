// Compiled by ClojureScript 1.11.4 {:optimizations :none}
goog.provide('front_cljs_app.core');
goog.require('cljs.core');
goog.require('goog.dom');
goog.require('goog.dom.classlist');
goog.require('goog.events');
goog.require('reagent.core');
goog.require('reagent.dom');
front_cljs_app.core.multiply = (function front_cljs_app$core$multiply(a,b){
return (a * b);
});
cljs.core.println.call(null,"Reloading in action....");
front_cljs_app.core.is_editable = reagent.core.atom.call(null,false);
front_cljs_app.core.edit_content_on = (function front_cljs_app$core$edit_content_on(){
console.log("Activando modo editable");

var h5_elements = document.querySelectorAll(".resizable-card h5");
var label_elements = document.querySelectorAll(".resizable-card label");
var button_elements = document.querySelectorAll("tab-widget button");
var seq__32566_32578 = cljs.core.seq.call(null,cljs.core.array_seq.call(null,h5_elements));
var chunk__32567_32579 = null;
var count__32568_32580 = (0);
var i__32569_32581 = (0);
while(true){
if((i__32569_32581 < count__32568_32580)){
var h5_32582 = cljs.core._nth.call(null,chunk__32567_32579,i__32569_32581);
(h5_32582.contentEditable = true);

goog.dom.classlist.add(h5_32582,"editable");


var G__32583 = seq__32566_32578;
var G__32584 = chunk__32567_32579;
var G__32585 = count__32568_32580;
var G__32586 = (i__32569_32581 + (1));
seq__32566_32578 = G__32583;
chunk__32567_32579 = G__32584;
count__32568_32580 = G__32585;
i__32569_32581 = G__32586;
continue;
} else {
var temp__5720__auto___32587 = cljs.core.seq.call(null,seq__32566_32578);
if(temp__5720__auto___32587){
var seq__32566_32588__$1 = temp__5720__auto___32587;
if(cljs.core.chunked_seq_QMARK_.call(null,seq__32566_32588__$1)){
var c__4679__auto___32589 = cljs.core.chunk_first.call(null,seq__32566_32588__$1);
var G__32590 = cljs.core.chunk_rest.call(null,seq__32566_32588__$1);
var G__32591 = c__4679__auto___32589;
var G__32592 = cljs.core.count.call(null,c__4679__auto___32589);
var G__32593 = (0);
seq__32566_32578 = G__32590;
chunk__32567_32579 = G__32591;
count__32568_32580 = G__32592;
i__32569_32581 = G__32593;
continue;
} else {
var h5_32594 = cljs.core.first.call(null,seq__32566_32588__$1);
(h5_32594.contentEditable = true);

goog.dom.classlist.add(h5_32594,"editable");


var G__32595 = cljs.core.next.call(null,seq__32566_32588__$1);
var G__32596 = null;
var G__32597 = (0);
var G__32598 = (0);
seq__32566_32578 = G__32595;
chunk__32567_32579 = G__32596;
count__32568_32580 = G__32597;
i__32569_32581 = G__32598;
continue;
}
} else {
}
}
break;
}

var seq__32570_32599 = cljs.core.seq.call(null,cljs.core.array_seq.call(null,label_elements));
var chunk__32571_32600 = null;
var count__32572_32601 = (0);
var i__32573_32602 = (0);
while(true){
if((i__32573_32602 < count__32572_32601)){
var label_32603 = cljs.core._nth.call(null,chunk__32571_32600,i__32573_32602);
(label_32603.contentEditable = true);

goog.dom.classlist.add(label_32603,"editable");


var G__32604 = seq__32570_32599;
var G__32605 = chunk__32571_32600;
var G__32606 = count__32572_32601;
var G__32607 = (i__32573_32602 + (1));
seq__32570_32599 = G__32604;
chunk__32571_32600 = G__32605;
count__32572_32601 = G__32606;
i__32573_32602 = G__32607;
continue;
} else {
var temp__5720__auto___32608 = cljs.core.seq.call(null,seq__32570_32599);
if(temp__5720__auto___32608){
var seq__32570_32609__$1 = temp__5720__auto___32608;
if(cljs.core.chunked_seq_QMARK_.call(null,seq__32570_32609__$1)){
var c__4679__auto___32610 = cljs.core.chunk_first.call(null,seq__32570_32609__$1);
var G__32611 = cljs.core.chunk_rest.call(null,seq__32570_32609__$1);
var G__32612 = c__4679__auto___32610;
var G__32613 = cljs.core.count.call(null,c__4679__auto___32610);
var G__32614 = (0);
seq__32570_32599 = G__32611;
chunk__32571_32600 = G__32612;
count__32572_32601 = G__32613;
i__32573_32602 = G__32614;
continue;
} else {
var label_32615 = cljs.core.first.call(null,seq__32570_32609__$1);
(label_32615.contentEditable = true);

goog.dom.classlist.add(label_32615,"editable");


var G__32616 = cljs.core.next.call(null,seq__32570_32609__$1);
var G__32617 = null;
var G__32618 = (0);
var G__32619 = (0);
seq__32570_32599 = G__32616;
chunk__32571_32600 = G__32617;
count__32572_32601 = G__32618;
i__32573_32602 = G__32619;
continue;
}
} else {
}
}
break;
}

var seq__32574 = cljs.core.seq.call(null,cljs.core.array_seq.call(null,button_elements));
var chunk__32575 = null;
var count__32576 = (0);
var i__32577 = (0);
while(true){
if((i__32577 < count__32576)){
var button = cljs.core._nth.call(null,chunk__32575,i__32577);
(button.contentEditable = true);

goog.dom.classlist.add(button,"editable");


var G__32620 = seq__32574;
var G__32621 = chunk__32575;
var G__32622 = count__32576;
var G__32623 = (i__32577 + (1));
seq__32574 = G__32620;
chunk__32575 = G__32621;
count__32576 = G__32622;
i__32577 = G__32623;
continue;
} else {
var temp__5720__auto__ = cljs.core.seq.call(null,seq__32574);
if(temp__5720__auto__){
var seq__32574__$1 = temp__5720__auto__;
if(cljs.core.chunked_seq_QMARK_.call(null,seq__32574__$1)){
var c__4679__auto__ = cljs.core.chunk_first.call(null,seq__32574__$1);
var G__32624 = cljs.core.chunk_rest.call(null,seq__32574__$1);
var G__32625 = c__4679__auto__;
var G__32626 = cljs.core.count.call(null,c__4679__auto__);
var G__32627 = (0);
seq__32574 = G__32624;
chunk__32575 = G__32625;
count__32576 = G__32626;
i__32577 = G__32627;
continue;
} else {
var button = cljs.core.first.call(null,seq__32574__$1);
(button.contentEditable = true);

goog.dom.classlist.add(button,"editable");


var G__32628 = cljs.core.next.call(null,seq__32574__$1);
var G__32629 = null;
var G__32630 = (0);
var G__32631 = (0);
seq__32574 = G__32628;
chunk__32575 = G__32629;
count__32576 = G__32630;
i__32577 = G__32631;
continue;
}
} else {
return null;
}
}
break;
}
});
front_cljs_app.core.edit_content_off = (function front_cljs_app$core$edit_content_off(){
console.log("Desactivando modo editable");

var editable_elements = document.querySelectorAll("[contenteditable='true']");
var seq__32632 = cljs.core.seq.call(null,cljs.core.array_seq.call(null,editable_elements));
var chunk__32633 = null;
var count__32634 = (0);
var i__32635 = (0);
while(true){
if((i__32635 < count__32634)){
var elm = cljs.core._nth.call(null,chunk__32633,i__32635);
console.log(elm);

(elm.contentEditable = false);

goog.dom.classlist.remove(elm,"editable");


var G__32636 = seq__32632;
var G__32637 = chunk__32633;
var G__32638 = count__32634;
var G__32639 = (i__32635 + (1));
seq__32632 = G__32636;
chunk__32633 = G__32637;
count__32634 = G__32638;
i__32635 = G__32639;
continue;
} else {
var temp__5720__auto__ = cljs.core.seq.call(null,seq__32632);
if(temp__5720__auto__){
var seq__32632__$1 = temp__5720__auto__;
if(cljs.core.chunked_seq_QMARK_.call(null,seq__32632__$1)){
var c__4679__auto__ = cljs.core.chunk_first.call(null,seq__32632__$1);
var G__32640 = cljs.core.chunk_rest.call(null,seq__32632__$1);
var G__32641 = c__4679__auto__;
var G__32642 = cljs.core.count.call(null,c__4679__auto__);
var G__32643 = (0);
seq__32632 = G__32640;
chunk__32633 = G__32641;
count__32634 = G__32642;
i__32635 = G__32643;
continue;
} else {
var elm = cljs.core.first.call(null,seq__32632__$1);
console.log(elm);

(elm.contentEditable = false);

goog.dom.classlist.remove(elm,"editable");


var G__32644 = cljs.core.next.call(null,seq__32632__$1);
var G__32645 = null;
var G__32646 = (0);
var G__32647 = (0);
seq__32632 = G__32644;
chunk__32633 = G__32645;
count__32634 = G__32646;
i__32635 = G__32647;
continue;
}
} else {
return null;
}
}
break;
}
});
front_cljs_app.core.toggle_edit_content = (function front_cljs_app$core$toggle_edit_content(){
cljs.core.swap_BANG_.call(null,front_cljs_app.core.is_editable,cljs.core.not);

if(cljs.core.truth_(cljs.core.deref.call(null,front_cljs_app.core.is_editable))){
return front_cljs_app.core.edit_content_on.call(null);
} else {
return front_cljs_app.core.edit_content_off.call(null);
}
});
goog.exportSymbol("toggleEditContent",front_cljs_app.core.toggle_edit_content);
front_cljs_app.core.close_windows = (function front_cljs_app$core$close_windows(window_number){
var modal_32648 = goog.dom.getElement(["modal-container",cljs.core.str.cljs$core$IFn$_invoke$arity$1(window_number)].join(''));
if(cljs.core.truth_(modal_32648)){
goog.dom.removeNode(modal_32648);
} else {
}

var win = goog.dom.getElement(["w3-card",cljs.core.str.cljs$core$IFn$_invoke$arity$1(window_number)].join(''));
if(cljs.core.truth_(win)){
return goog.dom.removeNode(win);
} else {
return null;
}
});
goog.exportSymbol("closeWindows",front_cljs_app.core.close_windows);
if((typeof front_cljs_app !== 'undefined') && (typeof front_cljs_app.core !== 'undefined') && (typeof front_cljs_app.core.app_state !== 'undefined')){
} else {
front_cljs_app.core.app_state = reagent.core.atom.call(null,new cljs.core.PersistentArrayMap(null, 2, [new cljs.core.Keyword(null,"current-page","current-page",-101294180),(1),new cljs.core.Keyword(null,"rows-per-page","rows-per-page",249655959),(5)], null));
}
front_cljs_app.core.get_table_rows = (function front_cljs_app$core$get_table_rows(id){
var table = document.getElementById(id);
var rows = table.querySelectorAll("tbody tr");
return cljs.core.vec.call(null,Array.from(rows));
});
front_cljs_app.core.display_rows = (function front_cljs_app$core$display_rows(rows,id){
var rows_per_page = new cljs.core.Keyword(null,"rows-per-page","rows-per-page",249655959).cljs$core$IFn$_invoke$arity$1(cljs.core.deref.call(null,front_cljs_app.core.app_state));
var current_page = new cljs.core.Keyword(null,"current-page","current-page",-101294180).cljs$core$IFn$_invoke$arity$1(cljs.core.deref.call(null,front_cljs_app.core.app_state));
var start = (rows_per_page * (current_page - (1)));
var end = (start + rows_per_page);
var seq__32649_32657 = cljs.core.seq.call(null,rows);
var chunk__32650_32658 = null;
var count__32651_32659 = (0);
var i__32652_32660 = (0);
while(true){
if((i__32652_32660 < count__32651_32659)){
var row_32661 = cljs.core._nth.call(null,chunk__32650_32658,i__32652_32660);
(row_32661.style.display = "none");


var G__32662 = seq__32649_32657;
var G__32663 = chunk__32650_32658;
var G__32664 = count__32651_32659;
var G__32665 = (i__32652_32660 + (1));
seq__32649_32657 = G__32662;
chunk__32650_32658 = G__32663;
count__32651_32659 = G__32664;
i__32652_32660 = G__32665;
continue;
} else {
var temp__5720__auto___32666 = cljs.core.seq.call(null,seq__32649_32657);
if(temp__5720__auto___32666){
var seq__32649_32667__$1 = temp__5720__auto___32666;
if(cljs.core.chunked_seq_QMARK_.call(null,seq__32649_32667__$1)){
var c__4679__auto___32668 = cljs.core.chunk_first.call(null,seq__32649_32667__$1);
var G__32669 = cljs.core.chunk_rest.call(null,seq__32649_32667__$1);
var G__32670 = c__4679__auto___32668;
var G__32671 = cljs.core.count.call(null,c__4679__auto___32668);
var G__32672 = (0);
seq__32649_32657 = G__32669;
chunk__32650_32658 = G__32670;
count__32651_32659 = G__32671;
i__32652_32660 = G__32672;
continue;
} else {
var row_32673 = cljs.core.first.call(null,seq__32649_32667__$1);
(row_32673.style.display = "none");


var G__32674 = cljs.core.next.call(null,seq__32649_32667__$1);
var G__32675 = null;
var G__32676 = (0);
var G__32677 = (0);
seq__32649_32657 = G__32674;
chunk__32650_32658 = G__32675;
count__32651_32659 = G__32676;
i__32652_32660 = G__32677;
continue;
}
} else {
}
}
break;
}

var seq__32653 = cljs.core.seq.call(null,cljs.core.subvec.call(null,rows,start,end));
var chunk__32654 = null;
var count__32655 = (0);
var i__32656 = (0);
while(true){
if((i__32656 < count__32655)){
var row = cljs.core._nth.call(null,chunk__32654,i__32656);
(row.style.display = "table-row");


var G__32678 = seq__32653;
var G__32679 = chunk__32654;
var G__32680 = count__32655;
var G__32681 = (i__32656 + (1));
seq__32653 = G__32678;
chunk__32654 = G__32679;
count__32655 = G__32680;
i__32656 = G__32681;
continue;
} else {
var temp__5720__auto__ = cljs.core.seq.call(null,seq__32653);
if(temp__5720__auto__){
var seq__32653__$1 = temp__5720__auto__;
if(cljs.core.chunked_seq_QMARK_.call(null,seq__32653__$1)){
var c__4679__auto__ = cljs.core.chunk_first.call(null,seq__32653__$1);
var G__32682 = cljs.core.chunk_rest.call(null,seq__32653__$1);
var G__32683 = c__4679__auto__;
var G__32684 = cljs.core.count.call(null,c__4679__auto__);
var G__32685 = (0);
seq__32653 = G__32682;
chunk__32654 = G__32683;
count__32655 = G__32684;
i__32656 = G__32685;
continue;
} else {
var row = cljs.core.first.call(null,seq__32653__$1);
(row.style.display = "table-row");


var G__32686 = cljs.core.next.call(null,seq__32653__$1);
var G__32687 = null;
var G__32688 = (0);
var G__32689 = (0);
seq__32653 = G__32686;
chunk__32654 = G__32687;
count__32655 = G__32688;
i__32656 = G__32689;
continue;
}
} else {
return null;
}
}
break;
}
});
front_cljs_app.core.update_pagination = (function front_cljs_app$core$update_pagination(container_id){
var rows = front_cljs_app.core.get_table_rows.call(null,container_id);
var total_rows = cljs.core.count.call(null,rows);
var rows_per_page = new cljs.core.Keyword(null,"rows-per-page","rows-per-page",249655959).cljs$core$IFn$_invoke$arity$1(cljs.core.deref.call(null,front_cljs_app.core.app_state));
var total_pages = Math.ceil((total_rows / rows_per_page));
var pagination_div = document.getElementById("pagination-controls");
if(cljs.core.truth_(pagination_div)){
document.getElementById(container_id).removeChild(pagination_div);
} else {
}

var new_pagination_div = document.createElement("div");
(new_pagination_div.id = "pagination-controls");

(new_pagination_div.className = "uk-margin uk-flex-center uk-flex");

document.getElementById("pagination-container").appendChild(new_pagination_div);

var max_buttons = (5);
var half_range = cljs.core.quot.call(null,max_buttons,(2));
var start_page = (function (){var x__4336__auto__ = (1);
var y__4337__auto__ = (new cljs.core.Keyword(null,"current-page","current-page",-101294180).cljs$core$IFn$_invoke$arity$1(cljs.core.deref.call(null,front_cljs_app.core.app_state)) - half_range);
return ((x__4336__auto__ > y__4337__auto__) ? x__4336__auto__ : y__4337__auto__);
})();
var end_page = (function (){var x__4339__auto__ = total_pages;
var y__4340__auto__ = (new cljs.core.Keyword(null,"current-page","current-page",-101294180).cljs$core$IFn$_invoke$arity$1(cljs.core.deref.call(null,front_cljs_app.core.app_state)) + half_range);
return ((x__4339__auto__ < y__4340__auto__) ? x__4339__auto__ : y__4340__auto__);
})();
var seq__32690 = cljs.core.seq.call(null,cljs.core.range.call(null,start_page,(end_page + (1))));
var chunk__32691 = null;
var count__32692 = (0);
var i__32693 = (0);
while(true){
if((i__32693 < count__32692)){
var page = cljs.core._nth.call(null,chunk__32691,i__32693);
var btn_32694 = document.createElement("button");
(btn_32694.innerText = page);

(btn_32694.className = "uk-button uk-button-default uk-margin-small-right");

btn_32694.addEventListener("click",((function (seq__32690,chunk__32691,count__32692,i__32693,btn_32694,page,max_buttons,half_range,start_page,end_page,new_pagination_div,rows,total_rows,rows_per_page,total_pages,pagination_div){
return (function (){
cljs.core.reset_BANG_.call(null,front_cljs_app.core.app_state,cljs.core.assoc.call(null,cljs.core.deref.call(null,front_cljs_app.core.app_state),new cljs.core.Keyword(null,"current-page","current-page",-101294180),page));

return front_cljs_app.core.display_rows.call(null,rows,container_id);
});})(seq__32690,chunk__32691,count__32692,i__32693,btn_32694,page,max_buttons,half_range,start_page,end_page,new_pagination_div,rows,total_rows,rows_per_page,total_pages,pagination_div))
);

new_pagination_div.appendChild(btn_32694);


var G__32695 = seq__32690;
var G__32696 = chunk__32691;
var G__32697 = count__32692;
var G__32698 = (i__32693 + (1));
seq__32690 = G__32695;
chunk__32691 = G__32696;
count__32692 = G__32697;
i__32693 = G__32698;
continue;
} else {
var temp__5720__auto__ = cljs.core.seq.call(null,seq__32690);
if(temp__5720__auto__){
var seq__32690__$1 = temp__5720__auto__;
if(cljs.core.chunked_seq_QMARK_.call(null,seq__32690__$1)){
var c__4679__auto__ = cljs.core.chunk_first.call(null,seq__32690__$1);
var G__32699 = cljs.core.chunk_rest.call(null,seq__32690__$1);
var G__32700 = c__4679__auto__;
var G__32701 = cljs.core.count.call(null,c__4679__auto__);
var G__32702 = (0);
seq__32690 = G__32699;
chunk__32691 = G__32700;
count__32692 = G__32701;
i__32693 = G__32702;
continue;
} else {
var page = cljs.core.first.call(null,seq__32690__$1);
var btn_32703 = document.createElement("button");
(btn_32703.innerText = page);

(btn_32703.className = "uk-button uk-button-default uk-margin-small-right");

btn_32703.addEventListener("click",((function (seq__32690,chunk__32691,count__32692,i__32693,btn_32703,page,seq__32690__$1,temp__5720__auto__,max_buttons,half_range,start_page,end_page,new_pagination_div,rows,total_rows,rows_per_page,total_pages,pagination_div){
return (function (){
cljs.core.reset_BANG_.call(null,front_cljs_app.core.app_state,cljs.core.assoc.call(null,cljs.core.deref.call(null,front_cljs_app.core.app_state),new cljs.core.Keyword(null,"current-page","current-page",-101294180),page));

return front_cljs_app.core.display_rows.call(null,rows,container_id);
});})(seq__32690,chunk__32691,count__32692,i__32693,btn_32703,page,seq__32690__$1,temp__5720__auto__,max_buttons,half_range,start_page,end_page,new_pagination_div,rows,total_rows,rows_per_page,total_pages,pagination_div))
);

new_pagination_div.appendChild(btn_32703);


var G__32704 = cljs.core.next.call(null,seq__32690__$1);
var G__32705 = null;
var G__32706 = (0);
var G__32707 = (0);
seq__32690 = G__32704;
chunk__32691 = G__32705;
count__32692 = G__32706;
i__32693 = G__32707;
continue;
}
} else {
return null;
}
}
break;
}
});
front_cljs_app.core.init_table = (function front_cljs_app$core$init_table(id){
front_cljs_app.core.display_rows.call(null,front_cljs_app.core.get_table_rows.call(null,id),id);

return front_cljs_app.core.update_pagination.call(null,id);
});
front_cljs_app.core.init_table.call(null,"#table-data1825");
front_cljs_app.core.mount = (function front_cljs_app$core$mount(el){
return console.log("Mountin app");
});
front_cljs_app.core.mount_app_element = (function front_cljs_app$core$mount_app_element(){
var temp__5720__auto__ = null;
if(cljs.core.truth_(temp__5720__auto__)){
var el = temp__5720__auto__;
return front_cljs_app.core.mount.call(null,el);
} else {
return null;
}
});
front_cljs_app.core.mount_app_element.call(null);
front_cljs_app.core.on_reload = (function front_cljs_app$core$on_reload(){
return front_cljs_app.core.mount_app_element.call(null);
});

//# sourceMappingURL=core.js.map
