function [J grad] = nnCostFunction(nn_params, ...
                                   input_layer_size, ...
                                   hidden_layer_size, ...
                                   num_labels, ...
                                   X, y, lambda)
%NNCOSTFUNCTION Implements the neural network cost function for a two layer
%neural network which performs classification
%   [J grad] = NNCOSTFUNCTON(nn_params, hidden_layer_size, num_labels, ...
%   X, y, lambda) computes the cost and gradient of the neural network. The
%   parameters for the neural network are "unrolled" into the vector
%   nn_params and need to be converted back into the weight matrices. 
% 
%   The returned parameter grad should be a "unrolled" vector of the
%   partial derivatives of the neural network.
%

% Reshape nn_params back into the parameters Theta1 and Theta2, the weight matrices
% for our 2 layer neural network
Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), ...
                 hidden_layer_size, (input_layer_size + 1));

Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), ...
                 num_labels, (hidden_layer_size + 1));

% Setup some useful variables
m = size(X, 1);
         
% You need to return the following variables correctly 
J = 0;
Theta1_grad = zeros(size(Theta1));
Theta2_grad = zeros(size(Theta2));

% ====================== YOUR CODE HERE ======================
% Instructions: You should complete the code by working through the
%               following parts.
%
% Part 1: Feedforward the neural network and return the cost in the
%         variable J. After implementing Part 1, you can verify that your
%         cost function computation is correct by verifying the cost
%         computed in ex4.m
%
% Part 2: Implement the backpropagation algorithm to compute the gradients
%         Theta1_grad and Theta2_grad. You should return the partial derivatives of
%         the cost function with respect to Theta1 and Theta2 in Theta1_grad and
%         Theta2_grad, respectively. After implementing Part 2, you can check
%         that your implementation is correct by running checkNNGradients
%
%         Note: The vector y passed into the function is a vector of labels
%               containing values from 1..K. You need to map this vector into a 
%               binary vector of 1's and 0's to be used with the neural network
%               cost function.
%
%         Hint: We recommend implementing backpropagation using a for-loop
%               over the training examples if you are implementing it for the 
%               first time.
%
% Part 3: Implement regularization with the cost function and gradients.
%
%         Hint: You can implement this around the code for
%               backpropagation. That is, you can compute the gradients for
%               the regularization separately and then add them to Theta1_grad
%               and Theta2_grad from Part 2.
%


    

a1 = [ones(m, 1) X];
z2 = a1 * Theta1';
a2 = sigmoid(z2);
a2 = [ones(m, 1) a2];
z3 = a2 * Theta2';
htheta = sigmoid(z3);

%================================ye rahe dg:D==========================================================================
% for k = 1:num_labels
%     yk = y == k;
%     hthetak = htheta(:, k);
%     Jk = 1 / m * sum(-yk .* log(hthetak) - (1 - yk) .* log(1 - hthetak));
%     J = J + Jk;
% end
%  
% regularization = lambda / (2 * m) * (sum(sum(Theta1(:, 2:end) .^ 2)) + sum(sum(Theta2(:, 2:end) .^ 2)));
% J = J + regularization;
%=======================================================================================================================
         
         yi=repmat(y,1,num_labels)==ones(m,1)*(1:num_labels);
         J=sum(sum( -yi.*log(htheta)-(1-yi).*log(1-htheta) ));
           
            J=J/m;
            reg=lambda/(2*m) *( sum(sum(Theta1(:,2:end).^2))+sum(sum(Theta2(:,2:end).^2)));
            J=J+reg;
% 
%             delta_3=zeros(size(htheta,1),size(htheta,2));
%             for i=1:5000
%                     hthetai=htheta(i,:);
%                     yi=zeros(num_labels,1)';%%create a new binary vector that correspods to k th label,(y is the our labels)
%                     yi(y(i))=1;         
%                     delta_3(i,:)=hthetai-yi;    
%             end
%             delta_2=Theta2'*delta_3'.*sigmoidGradient([ones(m,1)  z2])';

       
       delta_3= htheta-(repmat(y,1,num_labels)== repmat(1:num_labels,m,1));
%        for t = 1:m
%             delta_2 = Theta2' * delta_3(t,:)' .* sigmoidGradient([1, z2(t, :)])';
%             delta_2 = delta_2(2:end);
% 
%             Theta1_grad = Theta1_grad + delta_2 * a1(t, :);
%             Theta2_grad = Theta2_grad + delta_3(t,:)' * a2(t, :);
%        end
        delta_2 = Theta2' * delta_3' .* sigmoidGradient([ones(m,1), z2])';
        delta_2 = delta_2(2:end,:);
        Theta1_grad = Theta1_grad + delta_2 * a1;
        Theta2_grad = Theta2_grad + delta_3' * a2;
        
        Theta1_grad = Theta1_grad / m;
        Theta2_grad = Theta2_grad / m;


        Theta1_grad(:, 2:end) = Theta1_grad(:, 2:end) + lambda / m * Theta1(:, 2:end);
        Theta2_grad(:, 2:end) = Theta2_grad(:, 2:end) + lambda / m * Theta2(:, 2:end);

% =========================================================================

% Unroll gradients
grad = [Theta1_grad(:) ; Theta2_grad(:)];


end
