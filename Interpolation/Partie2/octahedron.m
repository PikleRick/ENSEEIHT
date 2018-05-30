% maillage octahedron

%  Example:
%
%     [ node_xyz, triangle_node ] = ply_to_tri_mesh ( 'berrad.ply' );
%
%     trisurf ( triangle_node', node_xyz(1,:), node_xyz(2,:), node_xyz(3,:) );
%

[S, F] = ply_to_tri_mesh('octahedron.ply');

sommets = S';
faces = F';