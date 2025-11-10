// Compiled by ClojureScript 1.11.4 {:optimizations :none}
goog.provide('cljs.repl');
goog.require('cljs.core');
goog.require('cljs.spec.alpha');
goog.require('goog.string');
goog.require('goog.string.format');
cljs.repl.print_doc = (function cljs$repl$print_doc(p__23740){
var map__23741 = p__23740;
var map__23741__$1 = cljs.core.__destructure_map.call(null,map__23741);
var m = map__23741__$1;
var n = cljs.core.get.call(null,map__23741__$1,new cljs.core.Keyword(null,"ns","ns",441598760));
var nm = cljs.core.get.call(null,map__23741__$1,new cljs.core.Keyword(null,"name","name",1843675177));
cljs.core.println.call(null,"-------------------------");

cljs.core.println.call(null,(function (){var or__4253__auto__ = new cljs.core.Keyword(null,"spec","spec",347520401).cljs$core$IFn$_invoke$arity$1(m);
if(cljs.core.truth_(or__4253__auto__)){
return or__4253__auto__;
} else {
return [(function (){var temp__5720__auto__ = new cljs.core.Keyword(null,"ns","ns",441598760).cljs$core$IFn$_invoke$arity$1(m);
if(cljs.core.truth_(temp__5720__auto__)){
var ns = temp__5720__auto__;
return [cljs.core.str.cljs$core$IFn$_invoke$arity$1(ns),"/"].join('');
} else {
return null;
}
})(),cljs.core.str.cljs$core$IFn$_invoke$arity$1(new cljs.core.Keyword(null,"name","name",1843675177).cljs$core$IFn$_invoke$arity$1(m))].join('');
}
})());

if(cljs.core.truth_(new cljs.core.Keyword(null,"protocol","protocol",652470118).cljs$core$IFn$_invoke$arity$1(m))){
cljs.core.println.call(null,"Protocol");
} else {
}

if(cljs.core.truth_(new cljs.core.Keyword(null,"forms","forms",2045992350).cljs$core$IFn$_invoke$arity$1(m))){
var seq__23742_23770 = cljs.core.seq.call(null,new cljs.core.Keyword(null,"forms","forms",2045992350).cljs$core$IFn$_invoke$arity$1(m));
var chunk__23743_23771 = null;
var count__23744_23772 = (0);
var i__23745_23773 = (0);
while(true){
if((i__23745_23773 < count__23744_23772)){
var f_23774 = cljs.core._nth.call(null,chunk__23743_23771,i__23745_23773);
cljs.core.println.call(null,"  ",f_23774);


var G__23775 = seq__23742_23770;
var G__23776 = chunk__23743_23771;
var G__23777 = count__23744_23772;
var G__23778 = (i__23745_23773 + (1));
seq__23742_23770 = G__23775;
chunk__23743_23771 = G__23776;
count__23744_23772 = G__23777;
i__23745_23773 = G__23778;
continue;
} else {
var temp__5720__auto___23779 = cljs.core.seq.call(null,seq__23742_23770);
if(temp__5720__auto___23779){
var seq__23742_23780__$1 = temp__5720__auto___23779;
if(cljs.core.chunked_seq_QMARK_.call(null,seq__23742_23780__$1)){
var c__4679__auto___23781 = cljs.core.chunk_first.call(null,seq__23742_23780__$1);
var G__23782 = cljs.core.chunk_rest.call(null,seq__23742_23780__$1);
var G__23783 = c__4679__auto___23781;
var G__23784 = cljs.core.count.call(null,c__4679__auto___23781);
var G__23785 = (0);
seq__23742_23770 = G__23782;
chunk__23743_23771 = G__23783;
count__23744_23772 = G__23784;
i__23745_23773 = G__23785;
continue;
} else {
var f_23786 = cljs.core.first.call(null,seq__23742_23780__$1);
cljs.core.println.call(null,"  ",f_23786);


var G__23787 = cljs.core.next.call(null,seq__23742_23780__$1);
var G__23788 = null;
var G__23789 = (0);
var G__23790 = (0);
seq__23742_23770 = G__23787;
chunk__23743_23771 = G__23788;
count__23744_23772 = G__23789;
i__23745_23773 = G__23790;
continue;
}
} else {
}
}
break;
}
} else {
if(cljs.core.truth_(new cljs.core.Keyword(null,"arglists","arglists",1661989754).cljs$core$IFn$_invoke$arity$1(m))){
var arglists_23791 = new cljs.core.Keyword(null,"arglists","arglists",1661989754).cljs$core$IFn$_invoke$arity$1(m);
if(cljs.core.truth_((function (){var or__4253__auto__ = new cljs.core.Keyword(null,"macro","macro",-867863404).cljs$core$IFn$_invoke$arity$1(m);
if(cljs.core.truth_(or__4253__auto__)){
return or__4253__auto__;
} else {
return new cljs.core.Keyword(null,"repl-special-function","repl-special-function",1262603725).cljs$core$IFn$_invoke$arity$1(m);
}
})())){
cljs.core.prn.call(null,arglists_23791);
} else {
cljs.core.prn.call(null,((cljs.core._EQ_.call(null,new cljs.core.Symbol(null,"quote","quote",1377916282,null),cljs.core.first.call(null,arglists_23791)))?cljs.core.second.call(null,arglists_23791):arglists_23791));
}
} else {
}
}

if(cljs.core.truth_(new cljs.core.Keyword(null,"special-form","special-form",-1326536374).cljs$core$IFn$_invoke$arity$1(m))){
cljs.core.println.call(null,"Special Form");

cljs.core.println.call(null," ",new cljs.core.Keyword(null,"doc","doc",1913296891).cljs$core$IFn$_invoke$arity$1(m));

if(cljs.core.contains_QMARK_.call(null,m,new cljs.core.Keyword(null,"url","url",276297046))){
if(cljs.core.truth_(new cljs.core.Keyword(null,"url","url",276297046).cljs$core$IFn$_invoke$arity$1(m))){
return cljs.core.println.call(null,["\n  Please see http://clojure.org/",cljs.core.str.cljs$core$IFn$_invoke$arity$1(new cljs.core.Keyword(null,"url","url",276297046).cljs$core$IFn$_invoke$arity$1(m))].join(''));
} else {
return null;
}
} else {
return cljs.core.println.call(null,["\n  Please see http://clojure.org/special_forms#",cljs.core.str.cljs$core$IFn$_invoke$arity$1(new cljs.core.Keyword(null,"name","name",1843675177).cljs$core$IFn$_invoke$arity$1(m))].join(''));
}
} else {
if(cljs.core.truth_(new cljs.core.Keyword(null,"macro","macro",-867863404).cljs$core$IFn$_invoke$arity$1(m))){
cljs.core.println.call(null,"Macro");
} else {
}

if(cljs.core.truth_(new cljs.core.Keyword(null,"spec","spec",347520401).cljs$core$IFn$_invoke$arity$1(m))){
cljs.core.println.call(null,"Spec");
} else {
}

if(cljs.core.truth_(new cljs.core.Keyword(null,"repl-special-function","repl-special-function",1262603725).cljs$core$IFn$_invoke$arity$1(m))){
cljs.core.println.call(null,"REPL Special Function");
} else {
}

cljs.core.println.call(null," ",new cljs.core.Keyword(null,"doc","doc",1913296891).cljs$core$IFn$_invoke$arity$1(m));

if(cljs.core.truth_(new cljs.core.Keyword(null,"protocol","protocol",652470118).cljs$core$IFn$_invoke$arity$1(m))){
var seq__23746_23792 = cljs.core.seq.call(null,new cljs.core.Keyword(null,"methods","methods",453930866).cljs$core$IFn$_invoke$arity$1(m));
var chunk__23747_23793 = null;
var count__23748_23794 = (0);
var i__23749_23795 = (0);
while(true){
if((i__23749_23795 < count__23748_23794)){
var vec__23758_23796 = cljs.core._nth.call(null,chunk__23747_23793,i__23749_23795);
var name_23797 = cljs.core.nth.call(null,vec__23758_23796,(0),null);
var map__23761_23798 = cljs.core.nth.call(null,vec__23758_23796,(1),null);
var map__23761_23799__$1 = cljs.core.__destructure_map.call(null,map__23761_23798);
var doc_23800 = cljs.core.get.call(null,map__23761_23799__$1,new cljs.core.Keyword(null,"doc","doc",1913296891));
var arglists_23801 = cljs.core.get.call(null,map__23761_23799__$1,new cljs.core.Keyword(null,"arglists","arglists",1661989754));
cljs.core.println.call(null);

cljs.core.println.call(null," ",name_23797);

cljs.core.println.call(null," ",arglists_23801);

if(cljs.core.truth_(doc_23800)){
cljs.core.println.call(null," ",doc_23800);
} else {
}


var G__23802 = seq__23746_23792;
var G__23803 = chunk__23747_23793;
var G__23804 = count__23748_23794;
var G__23805 = (i__23749_23795 + (1));
seq__23746_23792 = G__23802;
chunk__23747_23793 = G__23803;
count__23748_23794 = G__23804;
i__23749_23795 = G__23805;
continue;
} else {
var temp__5720__auto___23806 = cljs.core.seq.call(null,seq__23746_23792);
if(temp__5720__auto___23806){
var seq__23746_23807__$1 = temp__5720__auto___23806;
if(cljs.core.chunked_seq_QMARK_.call(null,seq__23746_23807__$1)){
var c__4679__auto___23808 = cljs.core.chunk_first.call(null,seq__23746_23807__$1);
var G__23809 = cljs.core.chunk_rest.call(null,seq__23746_23807__$1);
var G__23810 = c__4679__auto___23808;
var G__23811 = cljs.core.count.call(null,c__4679__auto___23808);
var G__23812 = (0);
seq__23746_23792 = G__23809;
chunk__23747_23793 = G__23810;
count__23748_23794 = G__23811;
i__23749_23795 = G__23812;
continue;
} else {
var vec__23762_23813 = cljs.core.first.call(null,seq__23746_23807__$1);
var name_23814 = cljs.core.nth.call(null,vec__23762_23813,(0),null);
var map__23765_23815 = cljs.core.nth.call(null,vec__23762_23813,(1),null);
var map__23765_23816__$1 = cljs.core.__destructure_map.call(null,map__23765_23815);
var doc_23817 = cljs.core.get.call(null,map__23765_23816__$1,new cljs.core.Keyword(null,"doc","doc",1913296891));
var arglists_23818 = cljs.core.get.call(null,map__23765_23816__$1,new cljs.core.Keyword(null,"arglists","arglists",1661989754));
cljs.core.println.call(null);

cljs.core.println.call(null," ",name_23814);

cljs.core.println.call(null," ",arglists_23818);

if(cljs.core.truth_(doc_23817)){
cljs.core.println.call(null," ",doc_23817);
} else {
}


var G__23819 = cljs.core.next.call(null,seq__23746_23807__$1);
var G__23820 = null;
var G__23821 = (0);
var G__23822 = (0);
seq__23746_23792 = G__23819;
chunk__23747_23793 = G__23820;
count__23748_23794 = G__23821;
i__23749_23795 = G__23822;
continue;
}
} else {
}
}
break;
}
} else {
}

if(cljs.core.truth_(n)){
var temp__5720__auto__ = cljs.spec.alpha.get_spec.call(null,cljs.core.symbol.call(null,cljs.core.str.cljs$core$IFn$_invoke$arity$1(cljs.core.ns_name.call(null,n)),cljs.core.name.call(null,nm)));
if(cljs.core.truth_(temp__5720__auto__)){
var fnspec = temp__5720__auto__;
cljs.core.print.call(null,"Spec");

var seq__23766 = cljs.core.seq.call(null,new cljs.core.PersistentVector(null, 3, 5, cljs.core.PersistentVector.EMPTY_NODE, [new cljs.core.Keyword(null,"args","args",1315556576),new cljs.core.Keyword(null,"ret","ret",-468222814),new cljs.core.Keyword(null,"fn","fn",-1175266204)], null));
var chunk__23767 = null;
var count__23768 = (0);
var i__23769 = (0);
while(true){
if((i__23769 < count__23768)){
var role = cljs.core._nth.call(null,chunk__23767,i__23769);
var temp__5720__auto___23823__$1 = cljs.core.get.call(null,fnspec,role);
if(cljs.core.truth_(temp__5720__auto___23823__$1)){
var spec_23824 = temp__5720__auto___23823__$1;
cljs.core.print.call(null,["\n ",cljs.core.name.call(null,role),":"].join(''),cljs.spec.alpha.describe.call(null,spec_23824));
} else {
}


var G__23825 = seq__23766;
var G__23826 = chunk__23767;
var G__23827 = count__23768;
var G__23828 = (i__23769 + (1));
seq__23766 = G__23825;
chunk__23767 = G__23826;
count__23768 = G__23827;
i__23769 = G__23828;
continue;
} else {
var temp__5720__auto____$1 = cljs.core.seq.call(null,seq__23766);
if(temp__5720__auto____$1){
var seq__23766__$1 = temp__5720__auto____$1;
if(cljs.core.chunked_seq_QMARK_.call(null,seq__23766__$1)){
var c__4679__auto__ = cljs.core.chunk_first.call(null,seq__23766__$1);
var G__23829 = cljs.core.chunk_rest.call(null,seq__23766__$1);
var G__23830 = c__4679__auto__;
var G__23831 = cljs.core.count.call(null,c__4679__auto__);
var G__23832 = (0);
seq__23766 = G__23829;
chunk__23767 = G__23830;
count__23768 = G__23831;
i__23769 = G__23832;
continue;
} else {
var role = cljs.core.first.call(null,seq__23766__$1);
var temp__5720__auto___23833__$2 = cljs.core.get.call(null,fnspec,role);
if(cljs.core.truth_(temp__5720__auto___23833__$2)){
var spec_23834 = temp__5720__auto___23833__$2;
cljs.core.print.call(null,["\n ",cljs.core.name.call(null,role),":"].join(''),cljs.spec.alpha.describe.call(null,spec_23834));
} else {
}


var G__23835 = cljs.core.next.call(null,seq__23766__$1);
var G__23836 = null;
var G__23837 = (0);
var G__23838 = (0);
seq__23766 = G__23835;
chunk__23767 = G__23836;
count__23768 = G__23837;
i__23769 = G__23838;
continue;
}
} else {
return null;
}
}
break;
}
} else {
return null;
}
} else {
return null;
}
}
});
/**
 * Constructs a data representation for a Error with keys:
 *  :cause - root cause message
 *  :phase - error phase
 *  :via - cause chain, with cause keys:
 *           :type - exception class symbol
 *           :message - exception message
 *           :data - ex-data
 *           :at - top stack element
 *  :trace - root cause stack elements
 */
cljs.repl.Error__GT_map = (function cljs$repl$Error__GT_map(o){
var base = (function (t){
return cljs.core.merge.call(null,new cljs.core.PersistentArrayMap(null, 1, [new cljs.core.Keyword(null,"type","type",1174270348),(((t instanceof cljs.core.ExceptionInfo))?new cljs.core.Symbol("cljs.core","ExceptionInfo","cljs.core/ExceptionInfo",701839050,null):(((t instanceof Error))?cljs.core.symbol.call(null,"js",t.name):null
))], null),(function (){var temp__5720__auto__ = cljs.core.ex_message.call(null,t);
if(cljs.core.truth_(temp__5720__auto__)){
var msg = temp__5720__auto__;
return new cljs.core.PersistentArrayMap(null, 1, [new cljs.core.Keyword(null,"message","message",-406056002),msg], null);
} else {
return null;
}
})(),(function (){var temp__5720__auto__ = cljs.core.ex_data.call(null,t);
if(cljs.core.truth_(temp__5720__auto__)){
var ed = temp__5720__auto__;
return new cljs.core.PersistentArrayMap(null, 1, [new cljs.core.Keyword(null,"data","data",-232669377),ed], null);
} else {
return null;
}
})());
});
var via = (function (){var via = cljs.core.PersistentVector.EMPTY;
var t = o;
while(true){
if(cljs.core.truth_(t)){
var G__23839 = cljs.core.conj.call(null,via,t);
var G__23840 = cljs.core.ex_cause.call(null,t);
via = G__23839;
t = G__23840;
continue;
} else {
return via;
}
break;
}
})();
var root = cljs.core.peek.call(null,via);
return cljs.core.merge.call(null,new cljs.core.PersistentArrayMap(null, 2, [new cljs.core.Keyword(null,"via","via",-1904457336),cljs.core.vec.call(null,cljs.core.map.call(null,base,via)),new cljs.core.Keyword(null,"trace","trace",-1082747415),null], null),(function (){var temp__5720__auto__ = cljs.core.ex_message.call(null,root);
if(cljs.core.truth_(temp__5720__auto__)){
var root_msg = temp__5720__auto__;
return new cljs.core.PersistentArrayMap(null, 1, [new cljs.core.Keyword(null,"cause","cause",231901252),root_msg], null);
} else {
return null;
}
})(),(function (){var temp__5720__auto__ = cljs.core.ex_data.call(null,root);
if(cljs.core.truth_(temp__5720__auto__)){
var data = temp__5720__auto__;
return new cljs.core.PersistentArrayMap(null, 1, [new cljs.core.Keyword(null,"data","data",-232669377),data], null);
} else {
return null;
}
})(),(function (){var temp__5720__auto__ = new cljs.core.Keyword("clojure.error","phase","clojure.error/phase",275140358).cljs$core$IFn$_invoke$arity$1(cljs.core.ex_data.call(null,o));
if(cljs.core.truth_(temp__5720__auto__)){
var phase = temp__5720__auto__;
return new cljs.core.PersistentArrayMap(null, 1, [new cljs.core.Keyword(null,"phase","phase",575722892),phase], null);
} else {
return null;
}
})());
});
/**
 * Returns an analysis of the phase, error, cause, and location of an error that occurred
 *   based on Throwable data, as returned by Throwable->map. All attributes other than phase
 *   are optional:
 *  :clojure.error/phase - keyword phase indicator, one of:
 *    :read-source :compile-syntax-check :compilation :macro-syntax-check :macroexpansion
 *    :execution :read-eval-result :print-eval-result
 *  :clojure.error/source - file name (no path)
 *  :clojure.error/line - integer line number
 *  :clojure.error/column - integer column number
 *  :clojure.error/symbol - symbol being expanded/compiled/invoked
 *  :clojure.error/class - cause exception class symbol
 *  :clojure.error/cause - cause exception message
 *  :clojure.error/spec - explain-data for spec error
 */
cljs.repl.ex_triage = (function cljs$repl$ex_triage(datafied_throwable){
var map__23843 = datafied_throwable;
var map__23843__$1 = cljs.core.__destructure_map.call(null,map__23843);
var via = cljs.core.get.call(null,map__23843__$1,new cljs.core.Keyword(null,"via","via",-1904457336));
var trace = cljs.core.get.call(null,map__23843__$1,new cljs.core.Keyword(null,"trace","trace",-1082747415));
var phase = cljs.core.get.call(null,map__23843__$1,new cljs.core.Keyword(null,"phase","phase",575722892),new cljs.core.Keyword(null,"execution","execution",253283524));
var map__23844 = cljs.core.last.call(null,via);
var map__23844__$1 = cljs.core.__destructure_map.call(null,map__23844);
var type = cljs.core.get.call(null,map__23844__$1,new cljs.core.Keyword(null,"type","type",1174270348));
var message = cljs.core.get.call(null,map__23844__$1,new cljs.core.Keyword(null,"message","message",-406056002));
var data = cljs.core.get.call(null,map__23844__$1,new cljs.core.Keyword(null,"data","data",-232669377));
var map__23845 = data;
var map__23845__$1 = cljs.core.__destructure_map.call(null,map__23845);
var problems = cljs.core.get.call(null,map__23845__$1,new cljs.core.Keyword("cljs.spec.alpha","problems","cljs.spec.alpha/problems",447400814));
var fn = cljs.core.get.call(null,map__23845__$1,new cljs.core.Keyword("cljs.spec.alpha","fn","cljs.spec.alpha/fn",408600443));
var caller = cljs.core.get.call(null,map__23845__$1,new cljs.core.Keyword("cljs.spec.test.alpha","caller","cljs.spec.test.alpha/caller",-398302390));
var map__23846 = new cljs.core.Keyword(null,"data","data",-232669377).cljs$core$IFn$_invoke$arity$1(cljs.core.first.call(null,via));
var map__23846__$1 = cljs.core.__destructure_map.call(null,map__23846);
var top_data = map__23846__$1;
var source = cljs.core.get.call(null,map__23846__$1,new cljs.core.Keyword("clojure.error","source","clojure.error/source",-2011936397));
return cljs.core.assoc.call(null,(function (){var G__23847 = phase;
var G__23847__$1 = (((G__23847 instanceof cljs.core.Keyword))?G__23847.fqn:null);
switch (G__23847__$1) {
case "read-source":
var map__23848 = data;
var map__23848__$1 = cljs.core.__destructure_map.call(null,map__23848);
var line = cljs.core.get.call(null,map__23848__$1,new cljs.core.Keyword("clojure.error","line","clojure.error/line",-1816287471));
var column = cljs.core.get.call(null,map__23848__$1,new cljs.core.Keyword("clojure.error","column","clojure.error/column",304721553));
var G__23849 = cljs.core.merge.call(null,new cljs.core.Keyword(null,"data","data",-232669377).cljs$core$IFn$_invoke$arity$1(cljs.core.second.call(null,via)),top_data);
var G__23849__$1 = (cljs.core.truth_(source)?cljs.core.assoc.call(null,G__23849,new cljs.core.Keyword("clojure.error","source","clojure.error/source",-2011936397),source):G__23849);
var G__23849__$2 = (cljs.core.truth_(new cljs.core.PersistentHashSet(null, new cljs.core.PersistentArrayMap(null, 2, ["NO_SOURCE_PATH",null,"NO_SOURCE_FILE",null], null), null).call(null,source))?cljs.core.dissoc.call(null,G__23849__$1,new cljs.core.Keyword("clojure.error","source","clojure.error/source",-2011936397)):G__23849__$1);
if(cljs.core.truth_(message)){
return cljs.core.assoc.call(null,G__23849__$2,new cljs.core.Keyword("clojure.error","cause","clojure.error/cause",-1879175742),message);
} else {
return G__23849__$2;
}

break;
case "compile-syntax-check":
case "compilation":
case "macro-syntax-check":
case "macroexpansion":
var G__23850 = top_data;
var G__23850__$1 = (cljs.core.truth_(source)?cljs.core.assoc.call(null,G__23850,new cljs.core.Keyword("clojure.error","source","clojure.error/source",-2011936397),source):G__23850);
var G__23850__$2 = (cljs.core.truth_(new cljs.core.PersistentHashSet(null, new cljs.core.PersistentArrayMap(null, 2, ["NO_SOURCE_PATH",null,"NO_SOURCE_FILE",null], null), null).call(null,source))?cljs.core.dissoc.call(null,G__23850__$1,new cljs.core.Keyword("clojure.error","source","clojure.error/source",-2011936397)):G__23850__$1);
var G__23850__$3 = (cljs.core.truth_(type)?cljs.core.assoc.call(null,G__23850__$2,new cljs.core.Keyword("clojure.error","class","clojure.error/class",278435890),type):G__23850__$2);
var G__23850__$4 = (cljs.core.truth_(message)?cljs.core.assoc.call(null,G__23850__$3,new cljs.core.Keyword("clojure.error","cause","clojure.error/cause",-1879175742),message):G__23850__$3);
if(cljs.core.truth_(problems)){
return cljs.core.assoc.call(null,G__23850__$4,new cljs.core.Keyword("clojure.error","spec","clojure.error/spec",2055032595),data);
} else {
return G__23850__$4;
}

break;
case "read-eval-result":
case "print-eval-result":
var vec__23851 = cljs.core.first.call(null,trace);
var source__$1 = cljs.core.nth.call(null,vec__23851,(0),null);
var method = cljs.core.nth.call(null,vec__23851,(1),null);
var file = cljs.core.nth.call(null,vec__23851,(2),null);
var line = cljs.core.nth.call(null,vec__23851,(3),null);
var G__23854 = top_data;
var G__23854__$1 = (cljs.core.truth_(line)?cljs.core.assoc.call(null,G__23854,new cljs.core.Keyword("clojure.error","line","clojure.error/line",-1816287471),line):G__23854);
var G__23854__$2 = (cljs.core.truth_(file)?cljs.core.assoc.call(null,G__23854__$1,new cljs.core.Keyword("clojure.error","source","clojure.error/source",-2011936397),file):G__23854__$1);
var G__23854__$3 = (cljs.core.truth_((function (){var and__4251__auto__ = source__$1;
if(cljs.core.truth_(and__4251__auto__)){
return method;
} else {
return and__4251__auto__;
}
})())?cljs.core.assoc.call(null,G__23854__$2,new cljs.core.Keyword("clojure.error","symbol","clojure.error/symbol",1544821994),(new cljs.core.PersistentVector(null,2,(5),cljs.core.PersistentVector.EMPTY_NODE,[source__$1,method],null))):G__23854__$2);
var G__23854__$4 = (cljs.core.truth_(type)?cljs.core.assoc.call(null,G__23854__$3,new cljs.core.Keyword("clojure.error","class","clojure.error/class",278435890),type):G__23854__$3);
if(cljs.core.truth_(message)){
return cljs.core.assoc.call(null,G__23854__$4,new cljs.core.Keyword("clojure.error","cause","clojure.error/cause",-1879175742),message);
} else {
return G__23854__$4;
}

break;
case "execution":
var vec__23855 = cljs.core.first.call(null,trace);
var source__$1 = cljs.core.nth.call(null,vec__23855,(0),null);
var method = cljs.core.nth.call(null,vec__23855,(1),null);
var file = cljs.core.nth.call(null,vec__23855,(2),null);
var line = cljs.core.nth.call(null,vec__23855,(3),null);
var file__$1 = cljs.core.first.call(null,cljs.core.remove.call(null,(function (p1__23842_SHARP_){
var or__4253__auto__ = (p1__23842_SHARP_ == null);
if(or__4253__auto__){
return or__4253__auto__;
} else {
return new cljs.core.PersistentHashSet(null, new cljs.core.PersistentArrayMap(null, 2, ["NO_SOURCE_PATH",null,"NO_SOURCE_FILE",null], null), null).call(null,p1__23842_SHARP_);
}
}),new cljs.core.PersistentVector(null, 2, 5, cljs.core.PersistentVector.EMPTY_NODE, [new cljs.core.Keyword(null,"file","file",-1269645878).cljs$core$IFn$_invoke$arity$1(caller),file], null)));
var err_line = (function (){var or__4253__auto__ = new cljs.core.Keyword(null,"line","line",212345235).cljs$core$IFn$_invoke$arity$1(caller);
if(cljs.core.truth_(or__4253__auto__)){
return or__4253__auto__;
} else {
return line;
}
})();
var G__23858 = new cljs.core.PersistentArrayMap(null, 1, [new cljs.core.Keyword("clojure.error","class","clojure.error/class",278435890),type], null);
var G__23858__$1 = (cljs.core.truth_(err_line)?cljs.core.assoc.call(null,G__23858,new cljs.core.Keyword("clojure.error","line","clojure.error/line",-1816287471),err_line):G__23858);
var G__23858__$2 = (cljs.core.truth_(message)?cljs.core.assoc.call(null,G__23858__$1,new cljs.core.Keyword("clojure.error","cause","clojure.error/cause",-1879175742),message):G__23858__$1);
var G__23858__$3 = (cljs.core.truth_((function (){var or__4253__auto__ = fn;
if(cljs.core.truth_(or__4253__auto__)){
return or__4253__auto__;
} else {
var and__4251__auto__ = source__$1;
if(cljs.core.truth_(and__4251__auto__)){
return method;
} else {
return and__4251__auto__;
}
}
})())?cljs.core.assoc.call(null,G__23858__$2,new cljs.core.Keyword("clojure.error","symbol","clojure.error/symbol",1544821994),(function (){var or__4253__auto__ = fn;
if(cljs.core.truth_(or__4253__auto__)){
return or__4253__auto__;
} else {
return (new cljs.core.PersistentVector(null,2,(5),cljs.core.PersistentVector.EMPTY_NODE,[source__$1,method],null));
}
})()):G__23858__$2);
var G__23858__$4 = (cljs.core.truth_(file__$1)?cljs.core.assoc.call(null,G__23858__$3,new cljs.core.Keyword("clojure.error","source","clojure.error/source",-2011936397),file__$1):G__23858__$3);
if(cljs.core.truth_(problems)){
return cljs.core.assoc.call(null,G__23858__$4,new cljs.core.Keyword("clojure.error","spec","clojure.error/spec",2055032595),data);
} else {
return G__23858__$4;
}

break;
default:
throw (new Error(["No matching clause: ",cljs.core.str.cljs$core$IFn$_invoke$arity$1(G__23847__$1)].join('')));

}
})(),new cljs.core.Keyword("clojure.error","phase","clojure.error/phase",275140358),phase);
});
/**
 * Returns a string from exception data, as produced by ex-triage.
 *   The first line summarizes the exception phase and location.
 *   The subsequent lines describe the cause.
 */
cljs.repl.ex_str = (function cljs$repl$ex_str(p__23862){
var map__23863 = p__23862;
var map__23863__$1 = cljs.core.__destructure_map.call(null,map__23863);
var triage_data = map__23863__$1;
var phase = cljs.core.get.call(null,map__23863__$1,new cljs.core.Keyword("clojure.error","phase","clojure.error/phase",275140358));
var source = cljs.core.get.call(null,map__23863__$1,new cljs.core.Keyword("clojure.error","source","clojure.error/source",-2011936397));
var line = cljs.core.get.call(null,map__23863__$1,new cljs.core.Keyword("clojure.error","line","clojure.error/line",-1816287471));
var column = cljs.core.get.call(null,map__23863__$1,new cljs.core.Keyword("clojure.error","column","clojure.error/column",304721553));
var symbol = cljs.core.get.call(null,map__23863__$1,new cljs.core.Keyword("clojure.error","symbol","clojure.error/symbol",1544821994));
var class$ = cljs.core.get.call(null,map__23863__$1,new cljs.core.Keyword("clojure.error","class","clojure.error/class",278435890));
var cause = cljs.core.get.call(null,map__23863__$1,new cljs.core.Keyword("clojure.error","cause","clojure.error/cause",-1879175742));
var spec = cljs.core.get.call(null,map__23863__$1,new cljs.core.Keyword("clojure.error","spec","clojure.error/spec",2055032595));
var loc = [cljs.core.str.cljs$core$IFn$_invoke$arity$1((function (){var or__4253__auto__ = source;
if(cljs.core.truth_(or__4253__auto__)){
return or__4253__auto__;
} else {
return "<cljs repl>";
}
})()),":",cljs.core.str.cljs$core$IFn$_invoke$arity$1((function (){var or__4253__auto__ = line;
if(cljs.core.truth_(or__4253__auto__)){
return or__4253__auto__;
} else {
return (1);
}
})()),(cljs.core.truth_(column)?[":",cljs.core.str.cljs$core$IFn$_invoke$arity$1(column)].join(''):"")].join('');
var class_name = cljs.core.name.call(null,(function (){var or__4253__auto__ = class$;
if(cljs.core.truth_(or__4253__auto__)){
return or__4253__auto__;
} else {
return "";
}
})());
var simple_class = class_name;
var cause_type = ((cljs.core.contains_QMARK_.call(null,new cljs.core.PersistentHashSet(null, new cljs.core.PersistentArrayMap(null, 2, ["RuntimeException",null,"Exception",null], null), null),simple_class))?"":[" (",simple_class,")"].join(''));
var format = goog.string.format;
var G__23864 = phase;
var G__23864__$1 = (((G__23864 instanceof cljs.core.Keyword))?G__23864.fqn:null);
switch (G__23864__$1) {
case "read-source":
return format.call(null,"Syntax error reading source at (%s).\n%s\n",loc,cause);

break;
case "macro-syntax-check":
return format.call(null,"Syntax error macroexpanding %sat (%s).\n%s",(cljs.core.truth_(symbol)?[cljs.core.str.cljs$core$IFn$_invoke$arity$1(symbol)," "].join(''):""),loc,(cljs.core.truth_(spec)?(function (){var sb__4795__auto__ = (new goog.string.StringBuffer());
var _STAR_print_newline_STAR__orig_val__23865_23874 = cljs.core._STAR_print_newline_STAR_;
var _STAR_print_fn_STAR__orig_val__23866_23875 = cljs.core._STAR_print_fn_STAR_;
var _STAR_print_newline_STAR__temp_val__23867_23876 = true;
var _STAR_print_fn_STAR__temp_val__23868_23877 = (function (x__4796__auto__){
return sb__4795__auto__.append(x__4796__auto__);
});
(cljs.core._STAR_print_newline_STAR_ = _STAR_print_newline_STAR__temp_val__23867_23876);

(cljs.core._STAR_print_fn_STAR_ = _STAR_print_fn_STAR__temp_val__23868_23877);

try{cljs.spec.alpha.explain_out.call(null,cljs.core.update.call(null,spec,new cljs.core.Keyword("cljs.spec.alpha","problems","cljs.spec.alpha/problems",447400814),(function (probs){
return cljs.core.map.call(null,(function (p1__23860_SHARP_){
return cljs.core.dissoc.call(null,p1__23860_SHARP_,new cljs.core.Keyword(null,"in","in",-1531184865));
}),probs);
}))
);
}finally {(cljs.core._STAR_print_fn_STAR_ = _STAR_print_fn_STAR__orig_val__23866_23875);

(cljs.core._STAR_print_newline_STAR_ = _STAR_print_newline_STAR__orig_val__23865_23874);
}
return cljs.core.str.cljs$core$IFn$_invoke$arity$1(sb__4795__auto__);
})():format.call(null,"%s\n",cause)));

break;
case "macroexpansion":
return format.call(null,"Unexpected error%s macroexpanding %sat (%s).\n%s\n",cause_type,(cljs.core.truth_(symbol)?[cljs.core.str.cljs$core$IFn$_invoke$arity$1(symbol)," "].join(''):""),loc,cause);

break;
case "compile-syntax-check":
return format.call(null,"Syntax error%s compiling %sat (%s).\n%s\n",cause_type,(cljs.core.truth_(symbol)?[cljs.core.str.cljs$core$IFn$_invoke$arity$1(symbol)," "].join(''):""),loc,cause);

break;
case "compilation":
return format.call(null,"Unexpected error%s compiling %sat (%s).\n%s\n",cause_type,(cljs.core.truth_(symbol)?[cljs.core.str.cljs$core$IFn$_invoke$arity$1(symbol)," "].join(''):""),loc,cause);

break;
case "read-eval-result":
return format.call(null,"Error reading eval result%s at %s (%s).\n%s\n",cause_type,symbol,loc,cause);

break;
case "print-eval-result":
return format.call(null,"Error printing return value%s at %s (%s).\n%s\n",cause_type,symbol,loc,cause);

break;
case "execution":
if(cljs.core.truth_(spec)){
return format.call(null,"Execution error - invalid arguments to %s at (%s).\n%s",symbol,loc,(function (){var sb__4795__auto__ = (new goog.string.StringBuffer());
var _STAR_print_newline_STAR__orig_val__23869_23878 = cljs.core._STAR_print_newline_STAR_;
var _STAR_print_fn_STAR__orig_val__23870_23879 = cljs.core._STAR_print_fn_STAR_;
var _STAR_print_newline_STAR__temp_val__23871_23880 = true;
var _STAR_print_fn_STAR__temp_val__23872_23881 = (function (x__4796__auto__){
return sb__4795__auto__.append(x__4796__auto__);
});
(cljs.core._STAR_print_newline_STAR_ = _STAR_print_newline_STAR__temp_val__23871_23880);

(cljs.core._STAR_print_fn_STAR_ = _STAR_print_fn_STAR__temp_val__23872_23881);

try{cljs.spec.alpha.explain_out.call(null,cljs.core.update.call(null,spec,new cljs.core.Keyword("cljs.spec.alpha","problems","cljs.spec.alpha/problems",447400814),(function (probs){
return cljs.core.map.call(null,(function (p1__23861_SHARP_){
return cljs.core.dissoc.call(null,p1__23861_SHARP_,new cljs.core.Keyword(null,"in","in",-1531184865));
}),probs);
}))
);
}finally {(cljs.core._STAR_print_fn_STAR_ = _STAR_print_fn_STAR__orig_val__23870_23879);

(cljs.core._STAR_print_newline_STAR_ = _STAR_print_newline_STAR__orig_val__23869_23878);
}
return cljs.core.str.cljs$core$IFn$_invoke$arity$1(sb__4795__auto__);
})());
} else {
return format.call(null,"Execution error%s at %s(%s).\n%s\n",cause_type,(cljs.core.truth_(symbol)?[cljs.core.str.cljs$core$IFn$_invoke$arity$1(symbol)," "].join(''):""),loc,cause);
}

break;
default:
throw (new Error(["No matching clause: ",cljs.core.str.cljs$core$IFn$_invoke$arity$1(G__23864__$1)].join('')));

}
});
cljs.repl.error__GT_str = (function cljs$repl$error__GT_str(error){
return cljs.repl.ex_str.call(null,cljs.repl.ex_triage.call(null,cljs.repl.Error__GT_map.call(null,error)));
});

//# sourceMappingURL=repl.js.map
