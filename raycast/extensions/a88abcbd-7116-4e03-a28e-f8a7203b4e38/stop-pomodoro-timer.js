"use strict";var Sn=Object.create;var L=Object.defineProperty;var gn=Object.getOwnPropertyDescriptor;var xn=Object.getOwnPropertyNames;var wn=Object.getPrototypeOf,bn=Object.prototype.hasOwnProperty;var a=(e,t)=>()=>(t||e((t={exports:{}}).exports,t),t.exports),vn=(e,t)=>{for(var r in t)L(e,r,{get:t[r],enumerable:!0})},Ee=(e,t,r,n)=>{if(t&&typeof t=="object"||typeof t=="function")for(let o of xn(t))!bn.call(e,o)&&o!==r&&L(e,o,{get:()=>t[o],enumerable:!(n=gn(t,o))||n.enumerable});return e};var Z=(e,t,r)=>(r=e!=null?Sn(wn(e)):{},Ee(t||!e||!e.__esModule?L(r,"default",{value:e,enumerable:!0}):r,e)),En=e=>Ee(L({},"__esModule",{value:!0}),e);var Re=a((Io,Oe)=>{Oe.exports=Ae;Ae.sync=Tn;var Ge=require("fs");function In(e,t){var r=t.pathExt!==void 0?t.pathExt:process.env.PATHEXT;if(!r||(r=r.split(";"),r.indexOf("")!==-1))return!0;for(var n=0;n<r.length;n++){var o=r[n].toLowerCase();if(o&&e.substr(-o.length).toLowerCase()===o)return!0}return!1}function Ce(e,t,r){return!e.isSymbolicLink()&&!e.isFile()?!1:In(t,r)}function Ae(e,t,r){Ge.stat(e,function(n,o){r(n,n?!1:Ce(o,e,t))})}function Tn(e,t){return Ce(Ge.statSync(e),e,t)}});var $e=a((To,_e)=>{_e.exports=Ne;Ne.sync=Pn;var qe=require("fs");function Ne(e,t,r){qe.stat(e,function(n,o){r(n,n?!1:ke(o,t))})}function Pn(e,t){return ke(qe.statSync(e),t)}function ke(e,t){return e.isFile()&&Gn(e,t)}function Gn(e,t){var r=e.mode,n=e.uid,o=e.gid,s=t.uid!==void 0?t.uid:process.getuid&&process.getuid(),i=t.gid!==void 0?t.gid:process.getgid&&process.getgid(),c=parseInt("100",8),u=parseInt("010",8),l=parseInt("001",8),f=c|u,h=r&l||r&u&&o===i||r&c&&n===s||r&f&&s===0;return h}});var Le=a((Go,Be)=>{var Po=require("fs"),j;process.platform==="win32"||global.TESTING_WINDOWS?j=Re():j=$e();Be.exports=ee;ee.sync=Cn;function ee(e,t,r){if(typeof t=="function"&&(r=t,t={}),!r){if(typeof Promise!="function")throw new TypeError("callback not provided");return new Promise(function(n,o){ee(e,t||{},function(s,i){s?o(s):n(i)})})}j(e,t||{},function(n,o){n&&(n.code==="EACCES"||t&&t.ignoreErrors)&&(n=null,o=!1),r(n,o)})}function Cn(e,t){try{return j.sync(e,t||{})}catch(r){if(t&&t.ignoreErrors||r.code==="EACCES")return!1;throw r}}});var Xe=a((Co,He)=>{var E=process.platform==="win32"||process.env.OSTYPE==="cygwin"||process.env.OSTYPE==="msys",Fe=require("path"),An=E?";":":",je=Le(),Me=e=>Object.assign(new Error(`not found: ${e}`),{code:"ENOENT"}),Ue=(e,t)=>{let r=t.colon||An,n=e.match(/\//)||E&&e.match(/\\/)?[""]:[...E?[process.cwd()]:[],...(t.path||process.env.PATH||"").split(r)],o=E?t.pathExt||process.env.PATHEXT||".EXE;.CMD;.BAT;.COM":"",s=E?o.split(r):[""];return E&&e.indexOf(".")!==-1&&s[0]!==""&&s.unshift(""),{pathEnv:n,pathExt:s,pathExtExe:o}},De=(e,t,r)=>{typeof t=="function"&&(r=t,t={}),t||(t={});let{pathEnv:n,pathExt:o,pathExtExe:s}=Ue(e,t),i=[],c=l=>new Promise((f,h)=>{if(l===n.length)return t.all&&i.length?f(i):h(Me(e));let m=n[l],y=/^".*"$/.test(m)?m.slice(1,-1):m,S=Fe.join(y,e),g=!y&&/^\.[\\\/]/.test(e)?e.slice(0,2)+S:S;f(u(g,l,0))}),u=(l,f,h)=>new Promise((m,y)=>{if(h===o.length)return m(c(f+1));let S=o[h];je(l+S,{pathExt:s},(g,v)=>{if(!g&&v)if(t.all)i.push(l+S);else return m(l+S);return m(u(l,f,h+1))})});return r?c(0).then(l=>r(null,l),r):c(0)},On=(e,t)=>{t=t||{};let{pathEnv:r,pathExt:n,pathExtExe:o}=Ue(e,t),s=[];for(let i=0;i<r.length;i++){let c=r[i],u=/^".*"$/.test(c)?c.slice(1,-1):c,l=Fe.join(u,e),f=!u&&/^\.[\\\/]/.test(e)?e.slice(0,2)+l:l;for(let h=0;h<n.length;h++){let m=f+n[h];try{if(je.sync(m,{pathExt:o}))if(t.all)s.push(m);else return m}catch{}}}if(t.all&&s.length)return s;if(t.nothrow)return null;throw Me(e)};He.exports=De;De.sync=On});var ne=a((Ao,te)=>{"use strict";var Ke=(e={})=>{let t=e.env||process.env;return(e.platform||process.platform)!=="win32"?"PATH":Object.keys(t).reverse().find(n=>n.toUpperCase()==="PATH")||"Path"};te.exports=Ke;te.exports.default=Ke});var Ve=a((Oo,Je)=>{"use strict";var We=require("path"),Rn=Xe(),qn=ne();function ze(e,t){let r=e.options.env||process.env,n=process.cwd(),o=e.options.cwd!=null,s=o&&process.chdir!==void 0&&!process.chdir.disabled;if(s)try{process.chdir(e.options.cwd)}catch{}let i;try{i=Rn.sync(e.command,{path:r[qn({env:r})],pathExt:t?We.delimiter:void 0})}catch{}finally{s&&process.chdir(n)}return i&&(i=We.resolve(o?e.options.cwd:"",i)),i}function Nn(e){return ze(e)||ze(e,!0)}Je.exports=Nn});var Ye=a((Ro,oe)=>{"use strict";var re=/([()\][%!^"`<>&|;, *?])/g;function kn(e){return e=e.replace(re,"^$1"),e}function _n(e,t){return e=`${e}`,e=e.replace(/(\\*)"/g,'$1$1\\"'),e=e.replace(/(\\*)$/,"$1$1"),e=`"${e}"`,e=e.replace(re,"^$1"),t&&(e=e.replace(re,"^$1")),e}oe.exports.command=kn;oe.exports.argument=_n});var Ze=a((qo,Qe)=>{"use strict";Qe.exports=/^#!(.*)/});var tt=a((No,et)=>{"use strict";var $n=Ze();et.exports=(e="")=>{let t=e.match($n);if(!t)return null;let[r,n]=t[0].replace(/#! ?/,"").split(" "),o=r.split("/").pop();return o==="env"?n:n?`${o} ${n}`:o}});var rt=a((ko,nt)=>{"use strict";var se=require("fs"),Bn=tt();function Ln(e){let r=Buffer.alloc(150),n;try{n=se.openSync(e,"r"),se.readSync(n,r,0,150,0),se.closeSync(n)}catch{}return Bn(r.toString())}nt.exports=Ln});var ct=a((_o,it)=>{"use strict";var Fn=require("path"),ot=Ve(),st=Ye(),jn=rt(),Mn=process.platform==="win32",Un=/\.(?:com|exe)$/i,Dn=/node_modules[\\/].bin[\\/][^\\/]+\.cmd$/i;function Hn(e){e.file=ot(e);let t=e.file&&jn(e.file);return t?(e.args.unshift(e.file),e.command=t,ot(e)):e.file}function Xn(e){if(!Mn)return e;let t=Hn(e),r=!Un.test(t);if(e.options.forceShell||r){let n=Dn.test(t);e.command=Fn.normalize(e.command),e.command=st.command(e.command),e.args=e.args.map(s=>st.argument(s,n));let o=[e.command].concat(e.args).join(" ");e.args=["/d","/s","/c",`"${o}"`],e.command=process.env.comspec||"cmd.exe",e.options.windowsVerbatimArguments=!0}return e}function Kn(e,t,r){t&&!Array.isArray(t)&&(r=t,t=null),t=t?t.slice(0):[],r=Object.assign({},r);let n={command:e,args:t,options:r,file:void 0,original:{command:e,args:t}};return r.shell?n:Xn(n)}it.exports=Kn});var lt=a(($o,ut)=>{"use strict";var ie=process.platform==="win32";function ce(e,t){return Object.assign(new Error(`${t} ${e.command} ENOENT`),{code:"ENOENT",errno:"ENOENT",syscall:`${t} ${e.command}`,path:e.command,spawnargs:e.args})}function Wn(e,t){if(!ie)return;let r=e.emit;e.emit=function(n,o){if(n==="exit"){let s=at(o,t,"spawn");if(s)return r.call(e,"error",s)}return r.apply(e,arguments)}}function at(e,t){return ie&&e===1&&!t.file?ce(t.original,"spawn"):null}function zn(e,t){return ie&&e===1&&!t.file?ce(t.original,"spawnSync"):null}ut.exports={hookChildProcess:Wn,verifyENOENT:at,verifyENOENTSync:zn,notFoundError:ce}});var pt=a((Bo,I)=>{"use strict";var dt=require("child_process"),ae=ct(),ue=lt();function ft(e,t,r){let n=ae(e,t,r),o=dt.spawn(n.command,n.args,n.options);return ue.hookChildProcess(o,n),o}function Jn(e,t,r){let n=ae(e,t,r),o=dt.spawnSync(n.command,n.args,n.options);return o.error=o.error||ue.verifyENOENTSync(o.status,n),o}I.exports=ft;I.exports.spawn=ft;I.exports.sync=Jn;I.exports._parse=ae;I.exports._enoent=ue});var ht=a((Lo,mt)=>{"use strict";mt.exports=e=>{let t=typeof e=="string"?`
`:10,r=typeof e=="string"?"\r":13;return e[e.length-1]===t&&(e=e.slice(0,e.length-1)),e[e.length-1]===r&&(e=e.slice(0,e.length-1)),e}});var gt=a((Fo,q)=>{"use strict";var R=require("path"),yt=ne(),St=e=>{e={cwd:process.cwd(),path:process.env[yt()],execPath:process.execPath,...e};let t,r=R.resolve(e.cwd),n=[];for(;t!==r;)n.push(R.join(r,"node_modules/.bin")),t=r,r=R.resolve(r,"..");let o=R.resolve(e.cwd,e.execPath,"..");return n.push(o),n.concat(e.path).join(R.delimiter)};q.exports=St;q.exports.default=St;q.exports.env=e=>{e={env:process.env,...e};let t={...e.env},r=yt({env:t});return e.path=t[r],t[r]=q.exports(e),t}});var wt=a((jo,le)=>{"use strict";var xt=(e,t)=>{for(let r of Reflect.ownKeys(t))Object.defineProperty(e,r,Object.getOwnPropertyDescriptor(t,r));return e};le.exports=xt;le.exports.default=xt});var vt=a((Mo,U)=>{"use strict";var Vn=wt(),M=new WeakMap,bt=(e,t={})=>{if(typeof e!="function")throw new TypeError("Expected a function");let r,n=0,o=e.displayName||e.name||"<anonymous>",s=function(...i){if(M.set(s,++n),n===1)r=e.apply(this,i),e=null;else if(t.throw===!0)throw new Error(`Function \`${o}\` can only be called once`);return r};return Vn(s,e),M.set(s,n),s};U.exports=bt;U.exports.default=bt;U.exports.callCount=e=>{if(!M.has(e))throw new Error(`The given function \`${e.name}\` is not wrapped by the \`onetime\` package`);return M.get(e)}});var Et=a(D=>{"use strict";Object.defineProperty(D,"__esModule",{value:!0});D.SIGNALS=void 0;var Yn=[{name:"SIGHUP",number:1,action:"terminate",description:"Terminal closed",standard:"posix"},{name:"SIGINT",number:2,action:"terminate",description:"User interruption with CTRL-C",standard:"ansi"},{name:"SIGQUIT",number:3,action:"core",description:"User interruption with CTRL-\\",standard:"posix"},{name:"SIGILL",number:4,action:"core",description:"Invalid machine instruction",standard:"ansi"},{name:"SIGTRAP",number:5,action:"core",description:"Debugger breakpoint",standard:"posix"},{name:"SIGABRT",number:6,action:"core",description:"Aborted",standard:"ansi"},{name:"SIGIOT",number:6,action:"core",description:"Aborted",standard:"bsd"},{name:"SIGBUS",number:7,action:"core",description:"Bus error due to misaligned, non-existing address or paging error",standard:"bsd"},{name:"SIGEMT",number:7,action:"terminate",description:"Command should be emulated but is not implemented",standard:"other"},{name:"SIGFPE",number:8,action:"core",description:"Floating point arithmetic error",standard:"ansi"},{name:"SIGKILL",number:9,action:"terminate",description:"Forced termination",standard:"posix",forced:!0},{name:"SIGUSR1",number:10,action:"terminate",description:"Application-specific signal",standard:"posix"},{name:"SIGSEGV",number:11,action:"core",description:"Segmentation fault",standard:"ansi"},{name:"SIGUSR2",number:12,action:"terminate",description:"Application-specific signal",standard:"posix"},{name:"SIGPIPE",number:13,action:"terminate",description:"Broken pipe or socket",standard:"posix"},{name:"SIGALRM",number:14,action:"terminate",description:"Timeout or timer",standard:"posix"},{name:"SIGTERM",number:15,action:"terminate",description:"Termination",standard:"ansi"},{name:"SIGSTKFLT",number:16,action:"terminate",description:"Stack is empty or overflowed",standard:"other"},{name:"SIGCHLD",number:17,action:"ignore",description:"Child process terminated, paused or unpaused",standard:"posix"},{name:"SIGCLD",number:17,action:"ignore",description:"Child process terminated, paused or unpaused",standard:"other"},{name:"SIGCONT",number:18,action:"unpause",description:"Unpaused",standard:"posix",forced:!0},{name:"SIGSTOP",number:19,action:"pause",description:"Paused",standard:"posix",forced:!0},{name:"SIGTSTP",number:20,action:"pause",description:'Paused using CTRL-Z or "suspend"',standard:"posix"},{name:"SIGTTIN",number:21,action:"pause",description:"Background process cannot read terminal input",standard:"posix"},{name:"SIGBREAK",number:21,action:"terminate",description:"User interruption with CTRL-BREAK",standard:"other"},{name:"SIGTTOU",number:22,action:"pause",description:"Background process cannot write to terminal output",standard:"posix"},{name:"SIGURG",number:23,action:"ignore",description:"Socket received out-of-band data",standard:"bsd"},{name:"SIGXCPU",number:24,action:"core",description:"Process timed out",standard:"bsd"},{name:"SIGXFSZ",number:25,action:"core",description:"File too big",standard:"bsd"},{name:"SIGVTALRM",number:26,action:"terminate",description:"Timeout or timer",standard:"bsd"},{name:"SIGPROF",number:27,action:"terminate",description:"Timeout or timer",standard:"bsd"},{name:"SIGWINCH",number:28,action:"ignore",description:"Terminal window size changed",standard:"bsd"},{name:"SIGIO",number:29,action:"terminate",description:"I/O is available",standard:"other"},{name:"SIGPOLL",number:29,action:"terminate",description:"Watched event",standard:"other"},{name:"SIGINFO",number:29,action:"ignore",description:"Request for process information",standard:"other"},{name:"SIGPWR",number:30,action:"terminate",description:"Device running out of power",standard:"systemv"},{name:"SIGSYS",number:31,action:"core",description:"Invalid system call",standard:"other"},{name:"SIGUNUSED",number:31,action:"terminate",description:"Invalid system call",standard:"other"}];D.SIGNALS=Yn});var de=a(T=>{"use strict";Object.defineProperty(T,"__esModule",{value:!0});T.SIGRTMAX=T.getRealtimeSignals=void 0;var Qn=function(){let e=Tt-It+1;return Array.from({length:e},Zn)};T.getRealtimeSignals=Qn;var Zn=function(e,t){return{name:`SIGRT${t+1}`,number:It+t,action:"terminate",description:"Application-specific signal (realtime)",standard:"posix"}},It=34,Tt=64;T.SIGRTMAX=Tt});var Pt=a(H=>{"use strict";Object.defineProperty(H,"__esModule",{value:!0});H.getSignals=void 0;var er=require("os"),tr=Et(),nr=de(),rr=function(){let e=(0,nr.getRealtimeSignals)();return[...tr.SIGNALS,...e].map(or)};H.getSignals=rr;var or=function({name:e,number:t,description:r,action:n,forced:o=!1,standard:s}){let{signals:{[e]:i}}=er.constants,c=i!==void 0;return{name:e,number:c?i:t,description:r,supported:c,action:n,forced:o,standard:s}}});var Ct=a(P=>{"use strict";Object.defineProperty(P,"__esModule",{value:!0});P.signalsByNumber=P.signalsByName=void 0;var sr=require("os"),Gt=Pt(),ir=de(),cr=function(){return(0,Gt.getSignals)().reduce(ar,{})},ar=function(e,{name:t,number:r,description:n,supported:o,action:s,forced:i,standard:c}){return{...e,[t]:{name:t,number:r,description:n,supported:o,action:s,forced:i,standard:c}}},ur=cr();P.signalsByName=ur;var lr=function(){let e=(0,Gt.getSignals)(),t=ir.SIGRTMAX+1,r=Array.from({length:t},(n,o)=>dr(o,e));return Object.assign({},...r)},dr=function(e,t){let r=fr(e,t);if(r===void 0)return{};let{name:n,description:o,supported:s,action:i,forced:c,standard:u}=r;return{[e]:{name:n,number:e,description:o,supported:s,action:i,forced:c,standard:u}}},fr=function(e,t){let r=t.find(({name:n})=>sr.constants.signals[n]===e);return r!==void 0?r:t.find(n=>n.number===e)},pr=lr();P.signalsByNumber=pr});var Ot=a((Ko,At)=>{"use strict";var{signalsByName:mr}=Ct(),hr=({timedOut:e,timeout:t,errorCode:r,signal:n,signalDescription:o,exitCode:s,isCanceled:i})=>e?`timed out after ${t} milliseconds`:i?"was canceled":r!==void 0?`failed with ${r}`:n!==void 0?`was killed with ${n} (${o})`:s!==void 0?`failed with exit code ${s}`:"failed",yr=({stdout:e,stderr:t,all:r,error:n,signal:o,exitCode:s,command:i,escapedCommand:c,timedOut:u,isCanceled:l,killed:f,parsed:{options:{timeout:h}}})=>{s=s===null?void 0:s,o=o===null?void 0:o;let m=o===void 0?void 0:mr[o].description,y=n&&n.code,g=`Command ${hr({timedOut:u,timeout:h,errorCode:y,signal:o,signalDescription:m,exitCode:s,isCanceled:l})}: ${i}`,v=Object.prototype.toString.call(n)==="[object Error]",$=v?`${g}
${n.message}`:g,B=[$,t,e].filter(Boolean).join(`
`);return v?(n.originalMessage=n.message,n.message=B):n=new Error(B),n.shortMessage=$,n.command=i,n.escapedCommand=c,n.exitCode=s,n.signal=o,n.signalDescription=m,n.stdout=e,n.stderr=t,r!==void 0&&(n.all=r),"bufferedData"in n&&delete n.bufferedData,n.failed=!0,n.timedOut=!!u,n.isCanceled=l,n.killed=f&&!u,n};At.exports=yr});var qt=a((Wo,fe)=>{"use strict";var X=["stdin","stdout","stderr"],Sr=e=>X.some(t=>e[t]!==void 0),Rt=e=>{if(!e)return;let{stdio:t}=e;if(t===void 0)return X.map(n=>e[n]);if(Sr(e))throw new Error(`It's not possible to provide \`stdio\` in combination with one of ${X.map(n=>`\`${n}\``).join(", ")}`);if(typeof t=="string")return t;if(!Array.isArray(t))throw new TypeError(`Expected \`stdio\` to be of type \`string\` or \`Array\`, got \`${typeof t}\``);let r=Math.max(t.length,X.length);return Array.from({length:r},(n,o)=>t[o])};fe.exports=Rt;fe.exports.node=e=>{let t=Rt(e);return t==="ipc"?"ipc":t===void 0||typeof t=="string"?[t,t,t,"ipc"]:t.includes("ipc")?t:[...t,"ipc"]}});var Nt=a((zo,K)=>{K.exports=["SIGABRT","SIGALRM","SIGHUP","SIGINT","SIGTERM"];process.platform!=="win32"&&K.exports.push("SIGVTALRM","SIGXCPU","SIGXFSZ","SIGUSR2","SIGTRAP","SIGSYS","SIGQUIT","SIGIOT");process.platform==="linux"&&K.exports.push("SIGIO","SIGPOLL","SIGPWR","SIGSTKFLT","SIGUNUSED")});var Lt=a((Jo,A)=>{var d=global.process,w=function(e){return e&&typeof e=="object"&&typeof e.removeListener=="function"&&typeof e.emit=="function"&&typeof e.reallyExit=="function"&&typeof e.listeners=="function"&&typeof e.kill=="function"&&typeof e.pid=="number"&&typeof e.on=="function"};w(d)?(kt=require("assert"),G=Nt(),_t=/^win/i.test(d.platform),N=require("events"),typeof N!="function"&&(N=N.EventEmitter),d.__signal_exit_emitter__?p=d.__signal_exit_emitter__:(p=d.__signal_exit_emitter__=new N,p.count=0,p.emitted={}),p.infinite||(p.setMaxListeners(1/0),p.infinite=!0),A.exports=function(e,t){if(!w(global.process))return function(){};kt.equal(typeof e,"function","a callback must be provided for exit handler"),C===!1&&pe();var r="exit";t&&t.alwaysLast&&(r="afterexit");var n=function(){p.removeListener(r,e),p.listeners("exit").length===0&&p.listeners("afterexit").length===0&&W()};return p.on(r,e),n},W=function(){!C||!w(global.process)||(C=!1,G.forEach(function(t){try{d.removeListener(t,z[t])}catch{}}),d.emit=J,d.reallyExit=me,p.count-=1)},A.exports.unload=W,b=function(t,r,n){p.emitted[t]||(p.emitted[t]=!0,p.emit(t,r,n))},z={},G.forEach(function(e){z[e]=function(){if(w(global.process)){var r=d.listeners(e);r.length===p.count&&(W(),b("exit",null,e),b("afterexit",null,e),_t&&e==="SIGHUP"&&(e="SIGINT"),d.kill(d.pid,e))}}}),A.exports.signals=function(){return G},C=!1,pe=function(){C||!w(global.process)||(C=!0,p.count+=1,G=G.filter(function(t){try{return d.on(t,z[t]),!0}catch{return!1}}),d.emit=Bt,d.reallyExit=$t)},A.exports.load=pe,me=d.reallyExit,$t=function(t){w(global.process)&&(d.exitCode=t||0,b("exit",d.exitCode,null),b("afterexit",d.exitCode,null),me.call(d,d.exitCode))},J=d.emit,Bt=function(t,r){if(t==="exit"&&w(global.process)){r!==void 0&&(d.exitCode=r);var n=J.apply(this,arguments);return b("exit",d.exitCode,null),b("afterexit",d.exitCode,null),n}else return J.apply(this,arguments)}):A.exports=function(){return function(){}};var kt,G,_t,N,p,W,b,z,C,pe,me,$t,J,Bt});var jt=a((Vo,Ft)=>{"use strict";var gr=require("os"),xr=Lt(),wr=1e3*5,br=(e,t="SIGTERM",r={})=>{let n=e(t);return vr(e,t,r,n),n},vr=(e,t,r,n)=>{if(!Er(t,r,n))return;let o=Tr(r),s=setTimeout(()=>{e("SIGKILL")},o);s.unref&&s.unref()},Er=(e,{forceKillAfterTimeout:t},r)=>Ir(e)&&t!==!1&&r,Ir=e=>e===gr.constants.signals.SIGTERM||typeof e=="string"&&e.toUpperCase()==="SIGTERM",Tr=({forceKillAfterTimeout:e=!0})=>{if(e===!0)return wr;if(!Number.isFinite(e)||e<0)throw new TypeError(`Expected the \`forceKillAfterTimeout\` option to be a non-negative integer, got \`${e}\` (${typeof e})`);return e},Pr=(e,t)=>{e.kill()&&(t.isCanceled=!0)},Gr=(e,t,r)=>{e.kill(t),r(Object.assign(new Error("Timed out"),{timedOut:!0,signal:t}))},Cr=(e,{timeout:t,killSignal:r="SIGTERM"},n)=>{if(t===0||t===void 0)return n;let o,s=new Promise((c,u)=>{o=setTimeout(()=>{Gr(e,r,u)},t)}),i=n.finally(()=>{clearTimeout(o)});return Promise.race([s,i])},Ar=({timeout:e})=>{if(e!==void 0&&(!Number.isFinite(e)||e<0))throw new TypeError(`Expected the \`timeout\` option to be a non-negative integer, got \`${e}\` (${typeof e})`)},Or=async(e,{cleanup:t,detached:r},n)=>{if(!t||r)return n;let o=xr(()=>{e.kill()});return n.finally(()=>{o()})};Ft.exports={spawnedKill:br,spawnedCancel:Pr,setupTimeout:Cr,validateTimeout:Ar,setExitHandler:Or}});var Ut=a((Yo,Mt)=>{"use strict";var x=e=>e!==null&&typeof e=="object"&&typeof e.pipe=="function";x.writable=e=>x(e)&&e.writable!==!1&&typeof e._write=="function"&&typeof e._writableState=="object";x.readable=e=>x(e)&&e.readable!==!1&&typeof e._read=="function"&&typeof e._readableState=="object";x.duplex=e=>x.writable(e)&&x.readable(e);x.transform=e=>x.duplex(e)&&typeof e._transform=="function";Mt.exports=x});var Ht=a((Qo,Dt)=>{"use strict";var{PassThrough:Rr}=require("stream");Dt.exports=e=>{e={...e};let{array:t}=e,{encoding:r}=e,n=r==="buffer",o=!1;t?o=!(r||n):r=r||"utf8",n&&(r=null);let s=new Rr({objectMode:o});r&&s.setEncoding(r);let i=0,c=[];return s.on("data",u=>{c.push(u),o?i=c.length:i+=u.length}),s.getBufferedValue=()=>t?c:n?Buffer.concat(c,i):c.join(""),s.getBufferedLength=()=>i,s}});var Xt=a((Zo,k)=>{"use strict";var{constants:qr}=require("buffer"),Nr=require("stream"),{promisify:kr}=require("util"),_r=Ht(),$r=kr(Nr.pipeline),V=class extends Error{constructor(){super("maxBuffer exceeded"),this.name="MaxBufferError"}};async function he(e,t){if(!e)throw new Error("Expected a stream");t={maxBuffer:1/0,...t};let{maxBuffer:r}=t,n=_r(t);return await new Promise((o,s)=>{let i=c=>{c&&n.getBufferedLength()<=qr.MAX_LENGTH&&(c.bufferedData=n.getBufferedValue()),s(c)};(async()=>{try{await $r(e,n),o()}catch(c){i(c)}})(),n.on("data",()=>{n.getBufferedLength()>r&&i(new V)})}),n.getBufferedValue()}k.exports=he;k.exports.buffer=(e,t)=>he(e,{...t,encoding:"buffer"});k.exports.array=(e,t)=>he(e,{...t,array:!0});k.exports.MaxBufferError=V});var Wt=a((es,Kt)=>{"use strict";var{PassThrough:Br}=require("stream");Kt.exports=function(){var e=[],t=new Br({objectMode:!0});return t.setMaxListeners(0),t.add=r,t.isEmpty=n,t.on("unpipe",o),Array.prototype.slice.call(arguments).forEach(r),t;function r(s){return Array.isArray(s)?(s.forEach(r),this):(e.push(s),s.once("end",o.bind(null,s)),s.once("error",t.emit.bind(t,"error")),s.pipe(t,{end:!1}),this)}function n(){return e.length==0}function o(s){e=e.filter(function(i){return i!==s}),!e.length&&t.readable&&t.end()}}});var Yt=a((ts,Vt)=>{"use strict";var Jt=Ut(),zt=Xt(),Lr=Wt(),Fr=(e,t)=>{t===void 0||e.stdin===void 0||(Jt(t)?t.pipe(e.stdin):e.stdin.end(t))},jr=(e,{all:t})=>{if(!t||!e.stdout&&!e.stderr)return;let r=Lr();return e.stdout&&r.add(e.stdout),e.stderr&&r.add(e.stderr),r},ye=async(e,t)=>{if(e){e.destroy();try{return await t}catch(r){return r.bufferedData}}},Se=(e,{encoding:t,buffer:r,maxBuffer:n})=>{if(!(!e||!r))return t?zt(e,{encoding:t,maxBuffer:n}):zt.buffer(e,{maxBuffer:n})},Mr=async({stdout:e,stderr:t,all:r},{encoding:n,buffer:o,maxBuffer:s},i)=>{let c=Se(e,{encoding:n,buffer:o,maxBuffer:s}),u=Se(t,{encoding:n,buffer:o,maxBuffer:s}),l=Se(r,{encoding:n,buffer:o,maxBuffer:s*2});try{return await Promise.all([i,c,u,l])}catch(f){return Promise.all([{error:f,signal:f.signal,timedOut:f.timedOut},ye(e,c),ye(t,u),ye(r,l)])}},Ur=({input:e})=>{if(Jt(e))throw new TypeError("The `input` option cannot be a stream in sync mode")};Vt.exports={handleInput:Fr,makeAllStream:jr,getSpawnedResult:Mr,validateInputSync:Ur}});var Zt=a((ns,Qt)=>{"use strict";var Dr=(async()=>{})().constructor.prototype,Hr=["then","catch","finally"].map(e=>[e,Reflect.getOwnPropertyDescriptor(Dr,e)]),Xr=(e,t)=>{for(let[r,n]of Hr){let o=typeof t=="function"?(...s)=>Reflect.apply(n.value,t(),s):n.value.bind(t);Reflect.defineProperty(e,r,{...n,value:o})}return e},Kr=e=>new Promise((t,r)=>{e.on("exit",(n,o)=>{t({exitCode:n,signal:o})}),e.on("error",n=>{r(n)}),e.stdin&&e.stdin.on("error",n=>{r(n)})});Qt.exports={mergePromise:Xr,getSpawnedPromise:Kr}});var nn=a((rs,tn)=>{"use strict";var en=(e,t=[])=>Array.isArray(t)?[e,...t]:[e],Wr=/^[\w.-]+$/,zr=/"/g,Jr=e=>typeof e!="string"||Wr.test(e)?e:`"${e.replace(zr,'\\"')}"`,Vr=(e,t)=>en(e,t).join(" "),Yr=(e,t)=>en(e,t).map(r=>Jr(r)).join(" "),Qr=/ +/g,Zr=e=>{let t=[];for(let r of e.trim().split(Qr)){let n=t[t.length-1];n&&n.endsWith("\\")?t[t.length-1]=`${n.slice(0,-1)} ${r}`:t.push(r)}return t};tn.exports={joinCommand:Vr,getEscapedCommand:Yr,parseCommand:Zr}});var ln=a((os,O)=>{"use strict";var eo=require("path"),ge=require("child_process"),to=pt(),no=ht(),ro=gt(),oo=vt(),Y=Ot(),on=qt(),{spawnedKill:so,spawnedCancel:io,setupTimeout:co,validateTimeout:ao,setExitHandler:uo}=jt(),{handleInput:lo,getSpawnedResult:fo,makeAllStream:po,validateInputSync:mo}=Yt(),{mergePromise:rn,getSpawnedPromise:ho}=Zt(),{joinCommand:sn,parseCommand:cn,getEscapedCommand:an}=nn(),yo=1e3*1e3*100,So=({env:e,extendEnv:t,preferLocal:r,localDir:n,execPath:o})=>{let s=t?{...process.env,...e}:e;return r?ro.env({env:s,cwd:n,execPath:o}):s},un=(e,t,r={})=>{let n=to._parse(e,t,r);return e=n.command,t=n.args,r=n.options,r={maxBuffer:yo,buffer:!0,stripFinalNewline:!0,extendEnv:!0,preferLocal:!1,localDir:r.cwd||process.cwd(),execPath:process.execPath,encoding:"utf8",reject:!0,cleanup:!0,all:!1,windowsHide:!0,...r},r.env=So(r),r.stdio=on(r),process.platform==="win32"&&eo.basename(e,".exe")==="cmd"&&t.unshift("/q"),{file:e,args:t,options:r,parsed:n}},_=(e,t,r)=>typeof t!="string"&&!Buffer.isBuffer(t)?r===void 0?void 0:"":e.stripFinalNewline?no(t):t,Q=(e,t,r)=>{let n=un(e,t,r),o=sn(e,t),s=an(e,t);ao(n.options);let i;try{i=ge.spawn(n.file,n.args,n.options)}catch(y){let S=new ge.ChildProcess,g=Promise.reject(Y({error:y,stdout:"",stderr:"",all:"",command:o,escapedCommand:s,parsed:n,timedOut:!1,isCanceled:!1,killed:!1}));return rn(S,g)}let c=ho(i),u=co(i,n.options,c),l=uo(i,n.options,u),f={isCanceled:!1};i.kill=so.bind(null,i.kill.bind(i)),i.cancel=io.bind(null,i,f);let m=oo(async()=>{let[{error:y,exitCode:S,signal:g,timedOut:v},$,B,yn]=await fo(i,n.options,l),xe=_(n.options,$),we=_(n.options,B),be=_(n.options,yn);if(y||S!==0||g!==null){let ve=Y({error:y,exitCode:S,signal:g,stdout:xe,stderr:we,all:be,command:o,escapedCommand:s,parsed:n,timedOut:v,isCanceled:f.isCanceled,killed:i.killed});if(!n.options.reject)return ve;throw ve}return{command:o,escapedCommand:s,exitCode:0,stdout:xe,stderr:we,all:be,failed:!1,timedOut:!1,isCanceled:!1,killed:!1}});return lo(i,n.options.input),i.all=po(i,n.options),rn(i,m)};O.exports=Q;O.exports.sync=(e,t,r)=>{let n=un(e,t,r),o=sn(e,t),s=an(e,t);mo(n.options);let i;try{i=ge.spawnSync(n.file,n.args,n.options)}catch(l){throw Y({error:l,stdout:"",stderr:"",all:"",command:o,escapedCommand:s,parsed:n,timedOut:!1,isCanceled:!1,killed:!1})}let c=_(n.options,i.stdout,i.error),u=_(n.options,i.stderr,i.error);if(i.error||i.status!==0||i.signal!==null){let l=Y({stdout:c,stderr:u,error:i.error,signal:i.signal,exitCode:i.status,command:o,escapedCommand:s,parsed:n,timedOut:i.error&&i.error.code==="ETIMEDOUT",isCanceled:!1,killed:i.signal!==null});if(!n.options.reject)return l;throw l}return{command:o,escapedCommand:s,exitCode:0,stdout:c,stderr:u,failed:!1,timedOut:!1,isCanceled:!1,killed:!1}};O.exports.command=(e,t)=>{let[r,...n]=cn(e);return Q(r,n,t)};O.exports.commandSync=(e,t)=>{let[r,...n]=cn(e);return Q.sync(r,n,t)};O.exports.node=(e,t,r={})=>{t&&!Array.isArray(t)&&typeof t=="object"&&(r=t,t=[]);let n=on.node(r),o=process.execArgv.filter(c=>!c.startsWith("--inspect")),{nodePath:s=process.execPath,nodeOptions:i=o}=r;return Q(s,[...i,e,...Array.isArray(t)?t:[]],{...r,stdin:void 0,stdout:void 0,stderr:void 0,stdio:n,shell:!1})}});var xo={};vn(xo,{default:()=>go});module.exports=En(xo);var Ie=Z(require("fs")),Te=()=>{try{return Ie.existsSync("/Applications/JustFocus.app")}catch(e){return console.error(String(e)),!1}};var F=require("@raycast/api"),Pe=async()=>{await(0,F.confirmAlert)({icon:{source:"extension-icon.png"},title:"Just Focus Not Installed",message:"Just Focus is not installed on your Mac. Please install Just Focus to use this command.",primaryAction:{title:"Get Just Focus",onAction:()=>{(0,F.open)("https://getjustfocus.com")}}})};var hn=require("@raycast/api");var dn=Z(require("node:process"),1),fn=Z(ln(),1);async function pn(e){if(dn.default.platform!=="darwin")throw new Error("macOS only");let{stdout:t}=await(0,fn.default)("osascript",["-e",e]);return t}var mn=async()=>{let e=`tell application "JustFocus"
     stop
end tell`;try{await pn(e)}catch(t){console.error(String(t))}};var go=async()=>{if(!Te()){await Pe();return}await(0,hn.showHUD)("Stopping Pomodoro Timer..."),await mn()};
