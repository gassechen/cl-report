// Compiled by ClojureScript 1.11.4 {:optimizations :none}
goog.provide('cider.nrepl.inlined.deps.suitable.v0v6v2.suitable.js_introspection');
goog.require('cljs.core');
goog.require('clojure.string');
goog.require('goog.object');
goog.scope(function(){
cider.nrepl.inlined.deps.suitable.v0v6v2.suitable.js_introspection.goog$module$goog$object = goog.module.get('goog.object');
});
cider.nrepl.inlined.deps.suitable.v0v6v2.suitable.js_introspection.own_property_descriptors = (cljs.core.truth_("getOwnPropertyDescriptors" in Object)?(function (obj){
return Object.getOwnPropertyDescriptors(obj);
}):(function (obj){
return cljs.core.clj__GT_js.call(null,cljs.core.into.call(null,cljs.core.PersistentArrayMap.EMPTY,cljs.core.map.call(null,(function (key){
return new cljs.core.PersistentVector(null, 2, 5, cljs.core.PersistentVector.EMPTY_NODE, [key,Object.getOwnPropertyDescriptor(obj,key)], null);
}),Object.getOwnPropertyNames(obj))));
}));
cider.nrepl.inlined.deps.suitable.v0v6v2.suitable.js_introspection.properties_by_prototype = (function cider$nrepl$inlined$deps$suitable$v0v6v2$suitable$js_introspection$properties_by_prototype(obj){
var obj__$1 = obj;
var protos = cljs.core.PersistentVector.EMPTY;
while(true){
if(cljs.core.truth_(obj__$1)){
var G__25205 = Object.getPrototypeOf(obj__$1);
var G__25206 = cljs.core.conj.call(null,protos,new cljs.core.PersistentArrayMap(null, 2, [new cljs.core.Keyword(null,"obj","obj",981763962),obj__$1,new cljs.core.Keyword(null,"props","props",453281727),cider.nrepl.inlined.deps.suitable.v0v6v2.suitable.js_introspection.own_property_descriptors.call(null,obj__$1)], null));
obj__$1 = G__25205;
protos = G__25206;
continue;
} else {
return protos;
}
break;
}
});
cider.nrepl.inlined.deps.suitable.v0v6v2.suitable.js_introspection.property_names_and_types = (function cider$nrepl$inlined$deps$suitable$v0v6v2$suitable$js_introspection$property_names_and_types(var_args){
var G__25208 = arguments.length;
switch (G__25208) {
case 1:
return cider.nrepl.inlined.deps.suitable.v0v6v2.suitable.js_introspection.property_names_and_types.cljs$core$IFn$_invoke$arity$1((arguments[(0)]));

break;
case 2:
return cider.nrepl.inlined.deps.suitable.v0v6v2.suitable.js_introspection.property_names_and_types.cljs$core$IFn$_invoke$arity$2((arguments[(0)]),(arguments[(1)]));

break;
default:
throw (new Error(["Invalid arity: ",cljs.core.str.cljs$core$IFn$_invoke$arity$1(arguments.length)].join('')));

}
});

(cider.nrepl.inlined.deps.suitable.v0v6v2.suitable.js_introspection.property_names_and_types.cljs$core$IFn$_invoke$arity$1 = (function (js_obj){
return cider.nrepl.inlined.deps.suitable.v0v6v2.suitable.js_introspection.property_names_and_types.call(null,js_obj,null);
}));

(cider.nrepl.inlined.deps.suitable.v0v6v2.suitable.js_introspection.property_names_and_types.cljs$core$IFn$_invoke$arity$2 = (function (js_obj,prefix){
var seen = cljs.core.volatile_BANG_.call(null,cljs.core.PersistentHashSet.EMPTY);
var iter__4652__auto__ = (function cider$nrepl$inlined$deps$suitable$v0v6v2$suitable$js_introspection$iter__25209(s__25210){
return (new cljs.core.LazySeq(null,(function (){
var s__25210__$1 = s__25210;
while(true){
var temp__5720__auto__ = cljs.core.seq.call(null,s__25210__$1);
if(temp__5720__auto__){
var xs__6277__auto__ = temp__5720__auto__;
var vec__25215 = cljs.core.first.call(null,xs__6277__auto__);
var i = cljs.core.nth.call(null,vec__25215,(0),null);
var map__25218 = cljs.core.nth.call(null,vec__25215,(1),null);
var map__25218__$1 = cljs.core.__destructure_map.call(null,map__25218);
var _obj = cljs.core.get.call(null,map__25218__$1,new cljs.core.Keyword(null,"_obj","_obj",-592966725));
var props = cljs.core.get.call(null,map__25218__$1,new cljs.core.Keyword(null,"props","props",453281727));
var iterys__4648__auto__ = ((function (s__25210__$1,vec__25215,i,map__25218,map__25218__$1,_obj,props,xs__6277__auto__,temp__5720__auto__,seen){
return (function cider$nrepl$inlined$deps$suitable$v0v6v2$suitable$js_introspection$iter__25209_$_iter__25211(s__25212){
return (new cljs.core.LazySeq(null,((function (s__25210__$1,vec__25215,i,map__25218,map__25218__$1,_obj,props,xs__6277__auto__,temp__5720__auto__,seen){
return (function (){
var s__25212__$1 = s__25212;
while(true){
var temp__5720__auto____$1 = cljs.core.seq.call(null,s__25212__$1);
if(temp__5720__auto____$1){
var s__25212__$2 = temp__5720__auto____$1;
if(cljs.core.chunked_seq_QMARK_.call(null,s__25212__$2)){
var c__4650__auto__ = cljs.core.chunk_first.call(null,s__25212__$2);
var size__4651__auto__ = cljs.core.count.call(null,c__4650__auto__);
var b__25214 = cljs.core.chunk_buffer.call(null,size__4651__auto__);
if((function (){var i__25213 = (0);
while(true){
if((i__25213 < size__4651__auto__)){
var key = cljs.core._nth.call(null,c__4650__auto__,i__25213);
if((function (){var and__4251__auto__ = cljs.core.not.call(null,cljs.core.get.call(null,cljs.core.deref.call(null,seen),key));
if(and__4251__auto__){
var and__4251__auto____$1 = (cljs.core.truth_((function (){var or__4253__auto__ = cljs.core._EQ_.call(null,"[object String]",Object.prototype.toString.call(js_obj));
if(or__4253__auto__){
return or__4253__auto__;
} else {
return Array.isArray(js_obj);
}
})())?cljs.core.not.call(null,cider.nrepl.inlined.deps.suitable.v0v6v2.suitable.js_introspection.goog$module$goog$object.get.call(null,cider.nrepl.inlined.deps.suitable.v0v6v2.suitable.js_introspection.goog$module$goog$object.get.call(null,props,key),"enumerable")):true);
if(and__4251__auto____$1){
return ((cljs.core.empty_QMARK_.call(null,prefix)) || (clojure.string.starts_with_QMARK_.call(null,key,prefix)));
} else {
return and__4251__auto____$1;
}
} else {
return and__4251__auto__;
}
})()){
cljs.core.chunk_append.call(null,b__25214,(function (){var prop = cider.nrepl.inlined.deps.suitable.v0v6v2.suitable.js_introspection.goog$module$goog$object.get.call(null,props,key);
cljs.core._vreset_BANG_.call(null,seen,cljs.core.conj.call(null,cljs.core._deref.call(null,seen),key));

return new cljs.core.PersistentArrayMap(null, 3, [new cljs.core.Keyword(null,"name","name",1843675177),key,new cljs.core.Keyword(null,"hierarchy","hierarchy",-1053470341),i,new cljs.core.Keyword(null,"type","type",1174270348),(function (){try{var temp__5718__auto__ = (function (){var or__4253__auto__ = cider.nrepl.inlined.deps.suitable.v0v6v2.suitable.js_introspection.goog$module$goog$object.get.call(null,prop,"value");
if(cljs.core.truth_(or__4253__auto__)){
return or__4253__auto__;
} else {
return cljs.core.apply.call(null,cider.nrepl.inlined.deps.suitable.v0v6v2.suitable.js_introspection.goog$module$goog$object.get.call(null,prop,"get"),cljs.core.PersistentVector.EMPTY);
}
})();
if(cljs.core.truth_(temp__5718__auto__)){
var value = temp__5718__auto__;
if(cljs.core.fn_QMARK_.call(null,value)){
return "function";
} else {
return "var";
}
} else {
return "var";
}
}catch (e25219){if((e25219 instanceof Error)){
var _e = e25219;
return "var";
} else {
throw e25219;

}
}})()], null);
})());

var G__25222 = (i__25213 + (1));
i__25213 = G__25222;
continue;
} else {
var G__25223 = (i__25213 + (1));
i__25213 = G__25223;
continue;
}
} else {
return true;
}
break;
}
})()){
return cljs.core.chunk_cons.call(null,cljs.core.chunk.call(null,b__25214),cider$nrepl$inlined$deps$suitable$v0v6v2$suitable$js_introspection$iter__25209_$_iter__25211.call(null,cljs.core.chunk_rest.call(null,s__25212__$2)));
} else {
return cljs.core.chunk_cons.call(null,cljs.core.chunk.call(null,b__25214),null);
}
} else {
var key = cljs.core.first.call(null,s__25212__$2);
if((function (){var and__4251__auto__ = cljs.core.not.call(null,cljs.core.get.call(null,cljs.core.deref.call(null,seen),key));
if(and__4251__auto__){
var and__4251__auto____$1 = (cljs.core.truth_((function (){var or__4253__auto__ = cljs.core._EQ_.call(null,"[object String]",Object.prototype.toString.call(js_obj));
if(or__4253__auto__){
return or__4253__auto__;
} else {
return Array.isArray(js_obj);
}
})())?cljs.core.not.call(null,cider.nrepl.inlined.deps.suitable.v0v6v2.suitable.js_introspection.goog$module$goog$object.get.call(null,cider.nrepl.inlined.deps.suitable.v0v6v2.suitable.js_introspection.goog$module$goog$object.get.call(null,props,key),"enumerable")):true);
if(and__4251__auto____$1){
return ((cljs.core.empty_QMARK_.call(null,prefix)) || (clojure.string.starts_with_QMARK_.call(null,key,prefix)));
} else {
return and__4251__auto____$1;
}
} else {
return and__4251__auto__;
}
})()){
return cljs.core.cons.call(null,(function (){var prop = cider.nrepl.inlined.deps.suitable.v0v6v2.suitable.js_introspection.goog$module$goog$object.get.call(null,props,key);
cljs.core._vreset_BANG_.call(null,seen,cljs.core.conj.call(null,cljs.core._deref.call(null,seen),key));

return new cljs.core.PersistentArrayMap(null, 3, [new cljs.core.Keyword(null,"name","name",1843675177),key,new cljs.core.Keyword(null,"hierarchy","hierarchy",-1053470341),i,new cljs.core.Keyword(null,"type","type",1174270348),(function (){try{var temp__5718__auto__ = (function (){var or__4253__auto__ = cider.nrepl.inlined.deps.suitable.v0v6v2.suitable.js_introspection.goog$module$goog$object.get.call(null,prop,"value");
if(cljs.core.truth_(or__4253__auto__)){
return or__4253__auto__;
} else {
return cljs.core.apply.call(null,cider.nrepl.inlined.deps.suitable.v0v6v2.suitable.js_introspection.goog$module$goog$object.get.call(null,prop,"get"),cljs.core.PersistentVector.EMPTY);
}
})();
if(cljs.core.truth_(temp__5718__auto__)){
var value = temp__5718__auto__;
if(cljs.core.fn_QMARK_.call(null,value)){
return "function";
} else {
return "var";
}
} else {
return "var";
}
}catch (e25220){if((e25220 instanceof Error)){
var _e = e25220;
return "var";
} else {
throw e25220;

}
}})()], null);
})(),cider$nrepl$inlined$deps$suitable$v0v6v2$suitable$js_introspection$iter__25209_$_iter__25211.call(null,cljs.core.rest.call(null,s__25212__$2)));
} else {
var G__25224 = cljs.core.rest.call(null,s__25212__$2);
s__25212__$1 = G__25224;
continue;
}
}
} else {
return null;
}
break;
}
});})(s__25210__$1,vec__25215,i,map__25218,map__25218__$1,_obj,props,xs__6277__auto__,temp__5720__auto__,seen))
,null,null));
});})(s__25210__$1,vec__25215,i,map__25218,map__25218__$1,_obj,props,xs__6277__auto__,temp__5720__auto__,seen))
;
var fs__4649__auto__ = cljs.core.seq.call(null,iterys__4648__auto__.call(null,cljs.core.js_keys.call(null,props)));
if(fs__4649__auto__){
return cljs.core.concat.call(null,fs__4649__auto__,cider$nrepl$inlined$deps$suitable$v0v6v2$suitable$js_introspection$iter__25209.call(null,cljs.core.rest.call(null,s__25210__$1)));
} else {
var G__25225 = cljs.core.rest.call(null,s__25210__$1);
s__25210__$1 = G__25225;
continue;
}
} else {
return null;
}
break;
}
}),null,null));
});
return iter__4652__auto__.call(null,cljs.core.map_indexed.call(null,cljs.core.vector,cider.nrepl.inlined.deps.suitable.v0v6v2.suitable.js_introspection.properties_by_prototype.call(null,js_obj)));
}));

(cider.nrepl.inlined.deps.suitable.v0v6v2.suitable.js_introspection.property_names_and_types.cljs$lang$maxFixedArity = 2);


//# sourceMappingURL=js_introspection.js.map
