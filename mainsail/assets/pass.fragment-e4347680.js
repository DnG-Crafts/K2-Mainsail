import{S as o}from"./Viewer-8a8ed1d4.js";import"./index-f28d7425.js";import"./vuetify-f4a6879d.js";import"./overlayscrollbars-44d87bcf.js";import"./echarts-ff51454d.js";import"./codemirror-0a1db0c7.js";const r="passPixelShader",e="varying vec2 vUV;uniform sampler2D textureSampler;\n#define CUSTOM_FRAGMENT_DEFINITIONS\nvoid main(void) \n{gl_FragColor=texture2D(textureSampler,vUV);}";o.ShadersStore[r]=e;const S={name:r,shader:e};export{S as passPixelShader};