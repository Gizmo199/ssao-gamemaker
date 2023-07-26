// CLEANUP GBUFFERS
if ( surface_exists(gColour) )	surface_free(gColour); 
if ( surface_exists(gNormal) )	surface_free(gNormal);
if ( surface_exists(gDepth) )	surface_free(gDepth);
if ( surface_exists(gSsao) )	surface_free(gSsao);