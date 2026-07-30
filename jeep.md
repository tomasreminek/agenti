Act as a senior 3D game developer, vehicle-physics programmer, technical artist, UI/UX designer, and performance optimization engineer.
Your task is to create a complete, highly polished, realistic 3D jungle jeep-driving experience that runs directly in a modern desktop web browser.
IMPORTANT OUTPUT RULE:
Return exactly ONE complete HTML file containing all HTML, CSS, and JavaScript.
The final response must contain only one code block with the finished HTML code.
Do not provide explanations, tutorials, summaries, pseudo-code, TODO comments, incomplete systems, or placeholders.
The game must be playable immediately after saving the code as index.html.
Do not split the solution into multiple files.
You may load stable libraries such as Three.js and Cannon-es from reliable CDNs, but:
Do not require local models, images, textures, audio files, JSON files, or other assets.
All vehicle geometry, terrain, vegetation, materials, effects, UI elements, and sounds must be created procedurally inside the HTML file.
Use ES modules correctly and ensure that the selected CDN versions are compatible.
Do not reference missing files or unsupported example modules.
Avoid dependencies that require a build system, npm, Node.js, or a server-side component.
PROJECT TITLE:
“Jungle Jeep: Off-Road Experience”
CORE VISION:
This is not a racing game and not an arcade combat game. It is a relaxing but challenging virtual off-road driving experience. The player drives a highly detailed red-and-black jeep through a large, atmospheric jungle environment on a damaged, muddy, uneven looping trail.
The experience must feel realistic, immersive, physically believable, visually impressive, and enjoyable even without missions or opponents. The jeep itself is the main hero of the experience, so spend significant development effort on its appearance, undercarriage, suspension, physics, animation, sound, cameras, and interaction with rough terrain.
==================================================
JEEP DESIGN — HIGHEST PRIORITY
==================================================
Create a detailed, recognizable off-road jeep procedurally using Three.js geometry. It must not look like a simple box with four cylinders.
COLOR DESIGN:
Main body color: deep glossy red.
Secondary parts: matte and semi-gloss black.
Add realistic roughness and metallic variation.
Use dark rubber, steel, chrome, glass, painted metal, and dusty/muddy materials where appropriate.
EXTERIOR DETAILS:
Strong off-road body shape with realistic proportions.
Detailed hood with shape variation and visible panel lines.
Front grille with multiple vertical slots.
Round front headlights with glass lenses, reflectors, and light emitters.
Front indicators and rear brake lights.
Strong black front and rear off-road bumpers.
Front bull bar or grille guard.
Visible fenders and wheel arches.
Side mirrors with reflective-looking material.
Windshield frame and transparent windshield.
Side windows or open off-road door design.
Door handles, hinges, body seams, and small mechanical details.
Spare tire mounted on the rear.
License plate with a simple generated label.
Exhaust pipe with a visible metal tip.
Fuel cap.
Roof or roll cage with proper support bars.
Optional roof-mounted lights.
Seats, dashboard, steering wheel, gear lever, pedals, and interior details.
Add subtle dust and mud buildup around lower body areas.
Body must cast and receive shadows.
WHEELS:
Four large off-road tires with chunky tread appearance.
Do not use plain smooth cylinders as the final visual tires.
Create visible tread blocks or a procedural tread pattern.
Add detailed rims, hubs, wheel nuts, brake discs, and dark wheel wells.
Front wheels must visibly steer.
All wheels must rotate according to vehicle speed.
Wheels must react independently to uneven ground.
UNDERCARRIAGE — EXTREMELY IMPORTANT:
The jeep must have a carefully modeled and clearly visible underside. Do not hide the bottom with a flat black rectangle.
Include:
Strong chassis rails.
Cross members.
Front and rear axles.
Front and rear differentials.
Drive shafts.
Transfer case or gearbox housing.
Suspension arms or leaf-spring-inspired components.
Coil springs and shock absorbers where suitable.
Exhaust pipe running under the vehicle.
Exhaust muffler.
Fuel tank.
Protective skid plates.
Wheel hubs and axle connections.
Mud and dark metallic materials under the vehicle.
The underside must remain visually coherent when viewed from a low camera angle. Components should not float, intersect incorrectly, or move independently from the vehicle without reason.
SUSPENSION ANIMATION:
Each wheel must visually move up and down according to terrain contact.
Suspension springs/shocks should compress and extend.
The jeep body should realistically pitch, roll, bounce, and settle.
Avoid excessive arcade-like wobbling.
Prevent wheels from visibly floating above or sinking deeply into the terrain.
Show axle articulation when opposite wheels encounter different heights.
==================================================
VEHICLE PHYSICS AND DRIVING FEEL
==================================================
Implement stable, believable off-road vehicle physics.
The driving must include:
Gradual acceleration.
Realistic braking.
Reverse gear.
Steering that becomes slightly less sensitive at higher speeds.
Tire grip affected by surface type.
Rolling resistance.
Gravity and downhill momentum.
Body roll during turning.
Nose dive during strong braking.
Slight rear squat during acceleration.
Suspension compression over bumps.
Reduced traction and mild sliding in mud.
Slower progress on steep or very rough terrain.
Vehicle must not instantly flip from small bumps.
Vehicle should recover naturally from moderate impacts.
Add a reset vehicle function if overturned or stuck.
Prevent unrealistic infinite acceleration.
Keep maximum speed appropriate for a rough jungle trail rather than a highway.
Prefer stable gameplay over overly complicated or unstable physics.
Suggested speed range:
Comfortable off-road cruising: 15–45 km/h.
Maximum speed should remain reasonable for this environment.
Display the current speed in km/h.
SURFACE RESPONSES:
Dirt: balanced grip.
Mud: reduced grip, slower acceleration, mild wheel slip.
Rocks: rough suspension response.
Shallow water: resistance, splashes, and reduced speed.
Grass: softer grip and subtle vibration.
Add lightweight visual feedback:
Dust behind wheels on dry dirt.
Mud particles on wet terrain.
Small water splashes when crossing puddles.
Very subtle camera shake on harsh impacts.
Do not overuse particles or camera shake.
==================================================
LARGE LOOPING JUNGLE MAP
==================================================
Create a visually large jungle environment with a closed-loop off-road trail. The player must be able to keep driving and eventually return to the starting region without reaching a dead end.
MAP REQUIREMENTS:
The road must form a long, natural closed circuit.
Avoid a simple circular road.
Use curves, elevation changes, switchbacks, narrow passages, open areas, and varied scenery.
Make the route feel significantly larger than the visible starting area.
Use terrain elevation and dense jungle to hide distant sections of the loop.
The environment should not visibly end near the player.
Use fog, terrain shaping, cliffs, vegetation, and distant silhouettes to disguise map boundaries.
Add safe invisible or natural boundaries so the jeep cannot fall forever outside the map.
TRAIL DESIGN:
Include:
Muddy sections.
Dry dirt sections.
Deep ruts.
Small and medium rocks.
Uneven bumps.
Shallow potholes.
Inclines and declines.
A small wooden bridge.
A shallow stream or water crossing.
Fallen logs near the road.
Narrow jungle sections.
A wider scenic clearing.
A rocky hill section.
Occasional roadside warning signs or wooden markers.
The road must remain driveable. Do not create impossible slopes, unavoidable traps, or obstacles that permanently block the jeep.
ROUGH TERRAIN:
Generate real terrain height variation rather than using only visual textures.
The jeep wheels must react physically or procedurally to actual terrain height.
Keep collision and visible terrain reasonably aligned.
Avoid random sharp spikes that launch the vehicle.
Use smooth noise plus intentionally placed road damage.
JUNGLE ENVIRONMENT:
Dense groups of trees with varied height, scale, rotation, and color.
Palm-like plants, broadleaf trees, bushes, ferns, grass, vines, roots, and ground plants.
Use instancing where possible for performance.
Keep large tree trunks and rocks out of the main driving line unless deliberately placed as avoidable obstacles.
Add exposed roots near selected road edges.
Add mossy rocks and damp ground areas.
Use natural placement rather than an obvious grid.
Add distant layered jungle silhouettes to make the map feel deeper.
==================================================
GRAPHICS AND ATMOSPHERE
==================================================
Aim for high-quality graphics while maintaining smooth performance.
LIGHTING:
Use a warm morning or late-afternoon atmosphere.
Directional sunlight with soft realistic shadows.
Hemisphere or ambient lighting for jungle fill light.
Sunlight should filter through trees.
Add subtle variation between bright clearings and darker jungle sections.
Avoid completely black shadows.
Make the red jeep body respond attractively to light.
RENDERING:
Enable antialiasing.
Use physically believable materials.
Use appropriate color space and tone mapping.
Use soft shadows with a sensible shadow-map size.
Use fog for depth and atmosphere.
Add subtle bloom only if it can be implemented reliably without breaking the single-file requirement.
Do not make the scene excessively saturated.
Avoid plastic-looking materials.
Keep transparent materials correctly sorted where possible.
SKY:
Create a procedural sky gradient or shader-based sky.
Include atmospheric haze.
Optional subtle moving clouds, but prioritize stability and performance.
GROUND:
Use procedural colors and material blending to create visual variation.
Differentiate mud, dirt, grass, rock, and wet areas.
Avoid a single flat-color terrain.
Add tire-track-like road details procedurally if feasible.
Wet surfaces may have slightly more reflection or lower roughness.
WATER:
Add a shallow stream or puddle section.
Use transparent water with subtle movement.
Include a visible riverbed or muddy bottom.
Keep water effects efficient.
DYNAMIC DETAILS:
Trees and plants may move very slightly in wind.
Headlights should illuminate the road when enabled.
Brake lights should activate while braking.
Reverse lights should activate while reversing.
Wheels should throw context-sensitive particles.
Add subtle exhaust smoke, especially at low speed, without excessive particles.
==================================================
CAMERA SYSTEM
==================================================
Camera movement must be smooth, comfortable, and polished. Avoid sudden snapping, harsh jitter, terrain clipping, and motion sickness.
Include at least these camera modes:
THIRD-PERSON CHASE CAMERA
Main default camera.
Positioned behind and above the jeep.
Smooth spring-like following and rotation.
Slightly looks ahead in the driving direction.
Camera distance can be adjusted with the mouse wheel.
Camera should not shake excessively with every small suspension movement.
Prevent camera from going below terrain when practical.
IN-CAR / DRIVER VIEW
Camera placed near the driver’s seat.
Dashboard, steering wheel, hood, windshield, and roll cage should be visible.
Steering wheel rotates with steering input.
Subtle head movement based on acceleration, braking, and bumps.
Mouse movement can look around within sensible limits.
Keep the view comfortable and stable.
EXTERNAL ORBIT / INSPECTION VIEW
Allow the player to orbit around the jeep with the mouse.
Useful for admiring the vehicle details.
Smooth orbit controls.
Restrict extreme clipping into the body.
UNDERCARRIAGE CAMERA
Add a dedicated cinematic low camera focused on the jeep’s underside.
It should clearly show axles, differential, suspension, drive shaft, shocks, and wheel articulation.
Position it low and slightly behind, beside, or under the jeep without being completely blocked.
Smoothly follow the jeep.
Avoid constant terrain clipping.
This camera is essential and must be functional.
OPTIONAL FRONT OR SIDE CINEMATIC CAMERA
A low front wheel or side suspension camera may be added if performance allows.
CAMERA CONTROLS:
Press C to cycle camera modes.
Press V for the undercarriage camera directly.
Mouse drag to look/orbit where appropriate.
Mouse wheel to adjust third-person distance.
Display the active camera mode briefly on screen.
==================================================
PLAYER CONTROLS
==================================================
DESKTOP CONTROLS:
W or Arrow Up: accelerate.
S or Arrow Down: brake/reverse.
A/D or Left/Right Arrows: steer.
Space: handbrake.
C: cycle cameras.
V: undercarriage camera.
H: headlights on/off.
R: safely reset the jeep to the nearest reasonable road position.
P or Escape: pause/unpause.
M: toggle audio.
Mouse drag: camera look/orbit.
Mouse wheel: camera distance where appropriate.
INPUT QUALITY:
Support simultaneous keyboard inputs.
Use smooth steering return.
Prevent browser scrolling from arrow keys and Space while playing.
Handle window focus loss safely by clearing stuck inputs.
Do not allow acceleration to remain stuck after releasing a key.
OPTIONAL MOBILE SUPPORT:
If it can be added without reducing desktop quality:
Add responsive touch buttons for steering, acceleration, braking, and camera switching.
Keep touch controls semi-transparent and unobtrusive.
==================================================
AUDIO
==================================================
Because external audio files are not allowed, generate lightweight audio with the Web Audio API.
Include:
Engine idle sound.
Engine pitch and intensity based on RPM/speed/throttle.
Low-frequency engine body.
Tire/terrain noise.
Subtle suspension or impact thumps on stronger bumps.
Water splash sound if feasible.
Jungle ambience with wind, insects, and occasional distant bird-like procedural sounds.
AUDIO RULES:
Audio must begin only after user interaction due to browser autoplay restrictions.
Include a clear “Start Experience” button.
Add mute/unmute functionality.
Keep volume balanced and comfortable.
Avoid harsh, repetitive, high-pitched oscillator noise.
If advanced sound becomes unstable, use a simpler polished system instead of broken audio.
==================================================
USER INTERFACE
==================================================
Create a clean, cinematic, minimal interface.
START SCREEN:
Game title: “Jungle Jeep: Off-Road Experience”
A short subtitle describing the experience.
“Start Experience” button.
Small controls summary.
Loading/progress indication if initialization takes time.
The start screen must disappear correctly after clicking Start.
IN-GAME HUD:
Digital speedometer in km/h.
Gear indicator: P/N/D/R or a simplified appropriate state.
Small throttle/brake indication.
Headlight status.
Current camera mode.
Optional compass.
Pause indicator.
Small reset hint if the jeep is overturned.
The HUD must:
Remain readable over bright and dark backgrounds.
Use modern semi-transparent panels.
Avoid covering too much of the driving view.
Scale properly on different screen sizes.
Add a brief controls overlay when the game starts, then fade it out.
==================================================
PERFORMANCE AND OPTIMIZATION
==================================================
The game should target smooth performance on a normal modern laptop.
Apply:
InstancedMesh for repeated trees, plants, rocks, and grass where possible.
Reasonable geometry detail.
Limited shadow-casting objects.
Distance-based detail reduction.
Culling or hiding distant small objects.
Reuse geometries and materials.
Use object pooling for dust, mud, splash, and exhaust particles.
Avoid creating new objects every animation frame.
Avoid unnecessary per-frame raycasts.
Cap pixel ratio to a sensible value, such as 1.5 or 2.
Use delta time correctly.
Clamp unusually large delta times after tab switching.
Avoid memory leaks and uncontrolled arrays.
Pause expensive updates when the game is paused or the tab is hidden.
Resize renderer and cameras correctly when the browser window changes.
Include an optional Graphics Quality selector on the start screen:
Low
Medium
High
Quality settings may change:
Shadow resolution.
Vegetation density.
Particle count.
Pixel ratio.
Draw distance.
The default should be Medium or High depending on expected stability.
==================================================
RELIABILITY AND BUG PREVENTION
==================================================
Before producing the final HTML, mentally audit the complete implementation.
The final result must avoid:
Blank screen on startup.
Incorrect CDN or module imports.
Undefined variables.
Missing functions.
Invalid JavaScript syntax.
Broken event listeners.
Duplicate animation loops.
NaN vehicle position or rotation.
Camera pointing into empty space.
Jeep spawning under the terrain.
Wheels detached from the jeep.
Terrain collision not matching visual terrain.
Permanent stuck keyboard input.
Vehicle exploding or flying due to unstable physics.
Excessive suspension vibration.
Huge frame-rate-dependent behavior.
Missing resize handling.
Audio errors before user interaction.
Textures or assets that fail because of unavailable external files.
An endless loading screen.
UI blocking keyboard or mouse input after starting.
Reset placing the jeep inside a rock, tree, or under the road.
If a complex feature risks breaking the game, implement a simpler stable version that still looks polished. A fully working experience is more important than a partially implemented advanced feature.
Add defensive programming:
Check required WebGL capabilities.
Show a friendly error message if WebGL initialization fails.
Use fallbacks where practical.
Clamp vehicle speed, suspension values, steering values, and camera distance.
Validate terrain height values.
Maintain a safe last-known road position for vehicle reset.
==================================================
PROCEDURAL IMPLEMENTATION REQUIREMENTS
==================================================
Since no external assets are allowed:
Build the jeep from multiple carefully arranged geometries.
Use grouped components with descriptive names.
Create road and terrain through procedural geometry.
Create material variation through vertex colors, canvas-generated textures, noise, or shaders.
If using CanvasTexture, generate it entirely in JavaScript.
Create jungle plants from reusable procedural geometry.
Generate rocks with irregular geometry rather than perfect spheres.
Generate road markers and signs from geometry and canvas textures.
Keep all generated textures within reasonable resolutions.
Organize the JavaScript into clear sections or classes such as:
App/Game initialization.
Renderer and lighting.
Terrain and loop road generation.
Jungle environment.
Detailed jeep construction.
Vehicle physics/controller.
Camera manager.
Particle manager.
Procedural audio manager.
Input manager.
UI manager.
Main update loop.
Use comments for important internal sections, but do not use comments as a replacement for implementation.
==================================================
GAMEPLAY POLISH
==================================================
Add small details that make the experience feel finished:
Smooth fade from start screen into gameplay.
Jeep starts parked on the trail in a visually appealing position.
Engine starts after the user presses Start.
Slight idle vibration.
Steering wheel movement.
Brake-light response.
Headlight cones and visible headlamp glow.
Speed-sensitive camera look-ahead.
Dust intensity based on throttle and ground type.
Suspension impact feedback.
Subtle body creaks or thumps if possible.
Camera mode notification that fades away.
Safe automatic recovery suggestion if overturned for several seconds.
A complete closed route with recognizable landmarks.
A start-area sign or small wooden checkpoint.
Optional lap counter only as a subtle exploration metric; do not turn it into a competitive racing game.
==================================================
ACCEPTANCE CHECKLIST
==================================================
The result is acceptable only if all of these are true:
[ ] It is exactly one HTML file.
[ ] It starts in a modern desktop browser.
[ ] It contains a playable red-and-black detailed jeep.
[ ] The jeep has a modeled, visible undercarriage.
[ ] Wheels rotate and front wheels steer.
[ ] Suspension visibly reacts to rough terrain.
[ ] The jeep can accelerate, brake, reverse, steer, and reset.
[ ] The map is a large non-trivial closed loop.
[ ] The route contains mud, bumps, rocks, elevation changes, and water.
[ ] The jungle contains varied procedural vegetation.
[ ] Third-person camera works smoothly.
[ ] In-car camera works and shows the interior.
[ ] Orbit/inspection camera works.
[ ] Dedicated undercarriage camera works.
[ ] Camera switching works using C and V.
[ ] Speedometer and basic HUD work.
[ ] Headlights and brake lights work.
[ ] Procedural engine audio starts after user interaction.
[ ] The interface includes a functional Start button.
[ ] The game does not depend on missing external assets.
[ ] The scene resizes correctly.
[ ] Performance optimizations are included.
[ ] There are no TODOs or placeholder implementations.
[ ] The response contains only the final HTML code.
FINAL INSTRUCTION:
Do not reduce this project to a basic demo, simple cube car, flat terrain, or short circular track. Spend most of the effort on the red-and-black jeep, its undercarriage, suspension articulation, realistic driving feel, camera polish, and jungle atmosphere.
Complete every critical system before adding optional features. Internally review the code for syntax, imports, initialization order, event handling, physics stability, camera behavior, and rendering issues.
If response length becomes limited, remove optional decorative features first. Never remove core driving, detailed jeep construction, undercarriage, suspension, loop trail, camera modes, controls, reset system, or HUD.
Now generate the final implementation.
Return only one complete HTML code block and nothing else.
