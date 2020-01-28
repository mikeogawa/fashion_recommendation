from renom_rl.utility.filter import DiscreteNodeChooser
from renom_rl.utility.fixer import transform_node_2_numpy
import numpy as np
import renom as rm
import os

def softmax(a):
    c = np.max(a)
    exp_a = np.exp(a - c)
    sum_exp_a = np.sum(exp_a)
    y = exp_a / sum_exp_a
    return y



class MaskMaxNodeChooser(DiscreteNodeChooser):

    def __call__(self,x,y):
        return self.forward(x,y)

    def forward(self, node_var, mask):
        node_var = transform_node_2_numpy(node_var)
        res = softmax(node_var - np.where(mask[None,...],0,100000))
        max_list = np.argmax(res, axis=1).reshape((-1, 1))

        if len(max_list) == 1:
            return int(max_list)
        else:
            return max_list

            
class NN(rm.Model):
    def __init__(self):
        self.d1=rm.Dense(32)
        self.d2=rm.Dense(32)
        self.d3=rm.Dense(32)
        self.d4=rm.Dense(1)

        self.emb = rm.Embedding(32,6)
        self.ad1 = rm.Dense(32)
        self.r=rm.Relu()

    def forward(self,x,action):
        h=self.d1(x)
#         h=self.r(h)
#         h=self.d2(h)
#         h=self.r(h)

        a = self.emb(action)
        a = self.r(a)
        a = self.ad1(a)
        a = self.r(a)
        h = rm.concat(h,a)
        h=self.d3(h)
        h=self.r(h)
        h=self.d4(h)
        return h



model=NN()
model.load("model.h5")
maskMaxNodeChooser=MaskMaxNodeChooser()
