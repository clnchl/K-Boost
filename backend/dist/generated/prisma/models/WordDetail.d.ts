import type * as runtime from "@prisma/client/runtime/library";
import type * as Prisma from "../internal/prismaNamespace.js";
export type WordDetailModel = runtime.Types.Result.DefaultSelection<Prisma.$WordDetailPayload>;
export type AggregateWordDetail = {
    _count: WordDetailCountAggregateOutputType | null;
    _min: WordDetailMinAggregateOutputType | null;
    _max: WordDetailMaxAggregateOutputType | null;
};
export type WordDetailMinAggregateOutputType = {
    id: string | null;
    wordId: string | null;
    korean: string | null;
    romanisation: string | null;
    translation: string | null;
    grammaticalType: string | null;
    exampleSentence: string | null;
};
export type WordDetailMaxAggregateOutputType = {
    id: string | null;
    wordId: string | null;
    korean: string | null;
    romanisation: string | null;
    translation: string | null;
    grammaticalType: string | null;
    exampleSentence: string | null;
};
export type WordDetailCountAggregateOutputType = {
    id: number;
    wordId: number;
    korean: number;
    romanisation: number;
    translation: number;
    grammaticalType: number;
    exampleSentence: number;
    _all: number;
};
export type WordDetailMinAggregateInputType = {
    id?: true;
    wordId?: true;
    korean?: true;
    romanisation?: true;
    translation?: true;
    grammaticalType?: true;
    exampleSentence?: true;
};
export type WordDetailMaxAggregateInputType = {
    id?: true;
    wordId?: true;
    korean?: true;
    romanisation?: true;
    translation?: true;
    grammaticalType?: true;
    exampleSentence?: true;
};
export type WordDetailCountAggregateInputType = {
    id?: true;
    wordId?: true;
    korean?: true;
    romanisation?: true;
    translation?: true;
    grammaticalType?: true;
    exampleSentence?: true;
    _all?: true;
};
export type WordDetailAggregateArgs<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs> = {
    where?: Prisma.WordDetailWhereInput;
    orderBy?: Prisma.WordDetailOrderByWithRelationInput | Prisma.WordDetailOrderByWithRelationInput[];
    cursor?: Prisma.WordDetailWhereUniqueInput;
    take?: number;
    skip?: number;
    _count?: true | WordDetailCountAggregateInputType;
    _min?: WordDetailMinAggregateInputType;
    _max?: WordDetailMaxAggregateInputType;
};
export type GetWordDetailAggregateType<T extends WordDetailAggregateArgs> = {
    [P in keyof T & keyof AggregateWordDetail]: P extends '_count' | 'count' ? T[P] extends true ? number : Prisma.GetScalarType<T[P], AggregateWordDetail[P]> : Prisma.GetScalarType<T[P], AggregateWordDetail[P]>;
};
export type WordDetailGroupByArgs<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs> = {
    where?: Prisma.WordDetailWhereInput;
    orderBy?: Prisma.WordDetailOrderByWithAggregationInput | Prisma.WordDetailOrderByWithAggregationInput[];
    by: Prisma.WordDetailScalarFieldEnum[] | Prisma.WordDetailScalarFieldEnum;
    having?: Prisma.WordDetailScalarWhereWithAggregatesInput;
    take?: number;
    skip?: number;
    _count?: WordDetailCountAggregateInputType | true;
    _min?: WordDetailMinAggregateInputType;
    _max?: WordDetailMaxAggregateInputType;
};
export type WordDetailGroupByOutputType = {
    id: string;
    wordId: string;
    korean: string;
    romanisation: string;
    translation: string;
    grammaticalType: string;
    exampleSentence: string;
    _count: WordDetailCountAggregateOutputType | null;
    _min: WordDetailMinAggregateOutputType | null;
    _max: WordDetailMaxAggregateOutputType | null;
};
type GetWordDetailGroupByPayload<T extends WordDetailGroupByArgs> = Prisma.PrismaPromise<Array<Prisma.PickEnumerable<WordDetailGroupByOutputType, T['by']> & {
    [P in ((keyof T) & (keyof WordDetailGroupByOutputType))]: P extends '_count' ? T[P] extends boolean ? number : Prisma.GetScalarType<T[P], WordDetailGroupByOutputType[P]> : Prisma.GetScalarType<T[P], WordDetailGroupByOutputType[P]>;
}>>;
export type WordDetailWhereInput = {
    AND?: Prisma.WordDetailWhereInput | Prisma.WordDetailWhereInput[];
    OR?: Prisma.WordDetailWhereInput[];
    NOT?: Prisma.WordDetailWhereInput | Prisma.WordDetailWhereInput[];
    id?: Prisma.StringFilter<"WordDetail"> | string;
    wordId?: Prisma.StringFilter<"WordDetail"> | string;
    korean?: Prisma.StringFilter<"WordDetail"> | string;
    romanisation?: Prisma.StringFilter<"WordDetail"> | string;
    translation?: Prisma.StringFilter<"WordDetail"> | string;
    grammaticalType?: Prisma.StringFilter<"WordDetail"> | string;
    exampleSentence?: Prisma.StringFilter<"WordDetail"> | string;
    word?: Prisma.XOR<Prisma.WordScalarRelationFilter, Prisma.WordWhereInput>;
};
export type WordDetailOrderByWithRelationInput = {
    id?: Prisma.SortOrder;
    wordId?: Prisma.SortOrder;
    korean?: Prisma.SortOrder;
    romanisation?: Prisma.SortOrder;
    translation?: Prisma.SortOrder;
    grammaticalType?: Prisma.SortOrder;
    exampleSentence?: Prisma.SortOrder;
    word?: Prisma.WordOrderByWithRelationInput;
};
export type WordDetailWhereUniqueInput = Prisma.AtLeast<{
    id?: string;
    wordId?: string;
    AND?: Prisma.WordDetailWhereInput | Prisma.WordDetailWhereInput[];
    OR?: Prisma.WordDetailWhereInput[];
    NOT?: Prisma.WordDetailWhereInput | Prisma.WordDetailWhereInput[];
    korean?: Prisma.StringFilter<"WordDetail"> | string;
    romanisation?: Prisma.StringFilter<"WordDetail"> | string;
    translation?: Prisma.StringFilter<"WordDetail"> | string;
    grammaticalType?: Prisma.StringFilter<"WordDetail"> | string;
    exampleSentence?: Prisma.StringFilter<"WordDetail"> | string;
    word?: Prisma.XOR<Prisma.WordScalarRelationFilter, Prisma.WordWhereInput>;
}, "id" | "wordId">;
export type WordDetailOrderByWithAggregationInput = {
    id?: Prisma.SortOrder;
    wordId?: Prisma.SortOrder;
    korean?: Prisma.SortOrder;
    romanisation?: Prisma.SortOrder;
    translation?: Prisma.SortOrder;
    grammaticalType?: Prisma.SortOrder;
    exampleSentence?: Prisma.SortOrder;
    _count?: Prisma.WordDetailCountOrderByAggregateInput;
    _max?: Prisma.WordDetailMaxOrderByAggregateInput;
    _min?: Prisma.WordDetailMinOrderByAggregateInput;
};
export type WordDetailScalarWhereWithAggregatesInput = {
    AND?: Prisma.WordDetailScalarWhereWithAggregatesInput | Prisma.WordDetailScalarWhereWithAggregatesInput[];
    OR?: Prisma.WordDetailScalarWhereWithAggregatesInput[];
    NOT?: Prisma.WordDetailScalarWhereWithAggregatesInput | Prisma.WordDetailScalarWhereWithAggregatesInput[];
    id?: Prisma.StringWithAggregatesFilter<"WordDetail"> | string;
    wordId?: Prisma.StringWithAggregatesFilter<"WordDetail"> | string;
    korean?: Prisma.StringWithAggregatesFilter<"WordDetail"> | string;
    romanisation?: Prisma.StringWithAggregatesFilter<"WordDetail"> | string;
    translation?: Prisma.StringWithAggregatesFilter<"WordDetail"> | string;
    grammaticalType?: Prisma.StringWithAggregatesFilter<"WordDetail"> | string;
    exampleSentence?: Prisma.StringWithAggregatesFilter<"WordDetail"> | string;
};
export type WordDetailCreateInput = {
    id: string;
    korean: string;
    romanisation: string;
    translation: string;
    grammaticalType: string;
    exampleSentence: string;
    word: Prisma.WordCreateNestedOneWithoutDetailInput;
};
export type WordDetailUncheckedCreateInput = {
    id: string;
    wordId: string;
    korean: string;
    romanisation: string;
    translation: string;
    grammaticalType: string;
    exampleSentence: string;
};
export type WordDetailUpdateInput = {
    id?: Prisma.StringFieldUpdateOperationsInput | string;
    korean?: Prisma.StringFieldUpdateOperationsInput | string;
    romanisation?: Prisma.StringFieldUpdateOperationsInput | string;
    translation?: Prisma.StringFieldUpdateOperationsInput | string;
    grammaticalType?: Prisma.StringFieldUpdateOperationsInput | string;
    exampleSentence?: Prisma.StringFieldUpdateOperationsInput | string;
    word?: Prisma.WordUpdateOneRequiredWithoutDetailNestedInput;
};
export type WordDetailUncheckedUpdateInput = {
    id?: Prisma.StringFieldUpdateOperationsInput | string;
    wordId?: Prisma.StringFieldUpdateOperationsInput | string;
    korean?: Prisma.StringFieldUpdateOperationsInput | string;
    romanisation?: Prisma.StringFieldUpdateOperationsInput | string;
    translation?: Prisma.StringFieldUpdateOperationsInput | string;
    grammaticalType?: Prisma.StringFieldUpdateOperationsInput | string;
    exampleSentence?: Prisma.StringFieldUpdateOperationsInput | string;
};
export type WordDetailCreateManyInput = {
    id: string;
    wordId: string;
    korean: string;
    romanisation: string;
    translation: string;
    grammaticalType: string;
    exampleSentence: string;
};
export type WordDetailUpdateManyMutationInput = {
    id?: Prisma.StringFieldUpdateOperationsInput | string;
    korean?: Prisma.StringFieldUpdateOperationsInput | string;
    romanisation?: Prisma.StringFieldUpdateOperationsInput | string;
    translation?: Prisma.StringFieldUpdateOperationsInput | string;
    grammaticalType?: Prisma.StringFieldUpdateOperationsInput | string;
    exampleSentence?: Prisma.StringFieldUpdateOperationsInput | string;
};
export type WordDetailUncheckedUpdateManyInput = {
    id?: Prisma.StringFieldUpdateOperationsInput | string;
    wordId?: Prisma.StringFieldUpdateOperationsInput | string;
    korean?: Prisma.StringFieldUpdateOperationsInput | string;
    romanisation?: Prisma.StringFieldUpdateOperationsInput | string;
    translation?: Prisma.StringFieldUpdateOperationsInput | string;
    grammaticalType?: Prisma.StringFieldUpdateOperationsInput | string;
    exampleSentence?: Prisma.StringFieldUpdateOperationsInput | string;
};
export type WordDetailNullableScalarRelationFilter = {
    is?: Prisma.WordDetailWhereInput | null;
    isNot?: Prisma.WordDetailWhereInput | null;
};
export type WordDetailCountOrderByAggregateInput = {
    id?: Prisma.SortOrder;
    wordId?: Prisma.SortOrder;
    korean?: Prisma.SortOrder;
    romanisation?: Prisma.SortOrder;
    translation?: Prisma.SortOrder;
    grammaticalType?: Prisma.SortOrder;
    exampleSentence?: Prisma.SortOrder;
};
export type WordDetailMaxOrderByAggregateInput = {
    id?: Prisma.SortOrder;
    wordId?: Prisma.SortOrder;
    korean?: Prisma.SortOrder;
    romanisation?: Prisma.SortOrder;
    translation?: Prisma.SortOrder;
    grammaticalType?: Prisma.SortOrder;
    exampleSentence?: Prisma.SortOrder;
};
export type WordDetailMinOrderByAggregateInput = {
    id?: Prisma.SortOrder;
    wordId?: Prisma.SortOrder;
    korean?: Prisma.SortOrder;
    romanisation?: Prisma.SortOrder;
    translation?: Prisma.SortOrder;
    grammaticalType?: Prisma.SortOrder;
    exampleSentence?: Prisma.SortOrder;
};
export type WordDetailCreateNestedOneWithoutWordInput = {
    create?: Prisma.XOR<Prisma.WordDetailCreateWithoutWordInput, Prisma.WordDetailUncheckedCreateWithoutWordInput>;
    connectOrCreate?: Prisma.WordDetailCreateOrConnectWithoutWordInput;
    connect?: Prisma.WordDetailWhereUniqueInput;
};
export type WordDetailUncheckedCreateNestedOneWithoutWordInput = {
    create?: Prisma.XOR<Prisma.WordDetailCreateWithoutWordInput, Prisma.WordDetailUncheckedCreateWithoutWordInput>;
    connectOrCreate?: Prisma.WordDetailCreateOrConnectWithoutWordInput;
    connect?: Prisma.WordDetailWhereUniqueInput;
};
export type WordDetailUpdateOneWithoutWordNestedInput = {
    create?: Prisma.XOR<Prisma.WordDetailCreateWithoutWordInput, Prisma.WordDetailUncheckedCreateWithoutWordInput>;
    connectOrCreate?: Prisma.WordDetailCreateOrConnectWithoutWordInput;
    upsert?: Prisma.WordDetailUpsertWithoutWordInput;
    disconnect?: Prisma.WordDetailWhereInput | boolean;
    delete?: Prisma.WordDetailWhereInput | boolean;
    connect?: Prisma.WordDetailWhereUniqueInput;
    update?: Prisma.XOR<Prisma.XOR<Prisma.WordDetailUpdateToOneWithWhereWithoutWordInput, Prisma.WordDetailUpdateWithoutWordInput>, Prisma.WordDetailUncheckedUpdateWithoutWordInput>;
};
export type WordDetailUncheckedUpdateOneWithoutWordNestedInput = {
    create?: Prisma.XOR<Prisma.WordDetailCreateWithoutWordInput, Prisma.WordDetailUncheckedCreateWithoutWordInput>;
    connectOrCreate?: Prisma.WordDetailCreateOrConnectWithoutWordInput;
    upsert?: Prisma.WordDetailUpsertWithoutWordInput;
    disconnect?: Prisma.WordDetailWhereInput | boolean;
    delete?: Prisma.WordDetailWhereInput | boolean;
    connect?: Prisma.WordDetailWhereUniqueInput;
    update?: Prisma.XOR<Prisma.XOR<Prisma.WordDetailUpdateToOneWithWhereWithoutWordInput, Prisma.WordDetailUpdateWithoutWordInput>, Prisma.WordDetailUncheckedUpdateWithoutWordInput>;
};
export type WordDetailCreateWithoutWordInput = {
    id: string;
    korean: string;
    romanisation: string;
    translation: string;
    grammaticalType: string;
    exampleSentence: string;
};
export type WordDetailUncheckedCreateWithoutWordInput = {
    id: string;
    korean: string;
    romanisation: string;
    translation: string;
    grammaticalType: string;
    exampleSentence: string;
};
export type WordDetailCreateOrConnectWithoutWordInput = {
    where: Prisma.WordDetailWhereUniqueInput;
    create: Prisma.XOR<Prisma.WordDetailCreateWithoutWordInput, Prisma.WordDetailUncheckedCreateWithoutWordInput>;
};
export type WordDetailUpsertWithoutWordInput = {
    update: Prisma.XOR<Prisma.WordDetailUpdateWithoutWordInput, Prisma.WordDetailUncheckedUpdateWithoutWordInput>;
    create: Prisma.XOR<Prisma.WordDetailCreateWithoutWordInput, Prisma.WordDetailUncheckedCreateWithoutWordInput>;
    where?: Prisma.WordDetailWhereInput;
};
export type WordDetailUpdateToOneWithWhereWithoutWordInput = {
    where?: Prisma.WordDetailWhereInput;
    data: Prisma.XOR<Prisma.WordDetailUpdateWithoutWordInput, Prisma.WordDetailUncheckedUpdateWithoutWordInput>;
};
export type WordDetailUpdateWithoutWordInput = {
    id?: Prisma.StringFieldUpdateOperationsInput | string;
    korean?: Prisma.StringFieldUpdateOperationsInput | string;
    romanisation?: Prisma.StringFieldUpdateOperationsInput | string;
    translation?: Prisma.StringFieldUpdateOperationsInput | string;
    grammaticalType?: Prisma.StringFieldUpdateOperationsInput | string;
    exampleSentence?: Prisma.StringFieldUpdateOperationsInput | string;
};
export type WordDetailUncheckedUpdateWithoutWordInput = {
    id?: Prisma.StringFieldUpdateOperationsInput | string;
    korean?: Prisma.StringFieldUpdateOperationsInput | string;
    romanisation?: Prisma.StringFieldUpdateOperationsInput | string;
    translation?: Prisma.StringFieldUpdateOperationsInput | string;
    grammaticalType?: Prisma.StringFieldUpdateOperationsInput | string;
    exampleSentence?: Prisma.StringFieldUpdateOperationsInput | string;
};
export type WordDetailSelect<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs> = runtime.Types.Extensions.GetSelect<{
    id?: boolean;
    wordId?: boolean;
    korean?: boolean;
    romanisation?: boolean;
    translation?: boolean;
    grammaticalType?: boolean;
    exampleSentence?: boolean;
    word?: boolean | Prisma.WordDefaultArgs<ExtArgs>;
}, ExtArgs["result"]["wordDetail"]>;
export type WordDetailSelectCreateManyAndReturn<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs> = runtime.Types.Extensions.GetSelect<{
    id?: boolean;
    wordId?: boolean;
    korean?: boolean;
    romanisation?: boolean;
    translation?: boolean;
    grammaticalType?: boolean;
    exampleSentence?: boolean;
    word?: boolean | Prisma.WordDefaultArgs<ExtArgs>;
}, ExtArgs["result"]["wordDetail"]>;
export type WordDetailSelectUpdateManyAndReturn<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs> = runtime.Types.Extensions.GetSelect<{
    id?: boolean;
    wordId?: boolean;
    korean?: boolean;
    romanisation?: boolean;
    translation?: boolean;
    grammaticalType?: boolean;
    exampleSentence?: boolean;
    word?: boolean | Prisma.WordDefaultArgs<ExtArgs>;
}, ExtArgs["result"]["wordDetail"]>;
export type WordDetailSelectScalar = {
    id?: boolean;
    wordId?: boolean;
    korean?: boolean;
    romanisation?: boolean;
    translation?: boolean;
    grammaticalType?: boolean;
    exampleSentence?: boolean;
};
export type WordDetailOmit<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs> = runtime.Types.Extensions.GetOmit<"id" | "wordId" | "korean" | "romanisation" | "translation" | "grammaticalType" | "exampleSentence", ExtArgs["result"]["wordDetail"]>;
export type WordDetailInclude<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs> = {
    word?: boolean | Prisma.WordDefaultArgs<ExtArgs>;
};
export type WordDetailIncludeCreateManyAndReturn<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs> = {
    word?: boolean | Prisma.WordDefaultArgs<ExtArgs>;
};
export type WordDetailIncludeUpdateManyAndReturn<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs> = {
    word?: boolean | Prisma.WordDefaultArgs<ExtArgs>;
};
export type $WordDetailPayload<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs> = {
    name: "WordDetail";
    objects: {
        word: Prisma.$WordPayload<ExtArgs>;
    };
    scalars: runtime.Types.Extensions.GetPayloadResult<{
        id: string;
        wordId: string;
        korean: string;
        romanisation: string;
        translation: string;
        grammaticalType: string;
        exampleSentence: string;
    }, ExtArgs["result"]["wordDetail"]>;
    composites: {};
};
export type WordDetailGetPayload<S extends boolean | null | undefined | WordDetailDefaultArgs> = runtime.Types.Result.GetResult<Prisma.$WordDetailPayload, S>;
export type WordDetailCountArgs<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs> = Omit<WordDetailFindManyArgs, 'select' | 'include' | 'distinct' | 'omit'> & {
    select?: WordDetailCountAggregateInputType | true;
};
export interface WordDetailDelegate<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs, GlobalOmitOptions = {}> {
    [K: symbol]: {
        types: Prisma.TypeMap<ExtArgs>['model']['WordDetail'];
        meta: {
            name: 'WordDetail';
        };
    };
    findUnique<T extends WordDetailFindUniqueArgs>(args: Prisma.SelectSubset<T, WordDetailFindUniqueArgs<ExtArgs>>): Prisma.Prisma__WordDetailClient<runtime.Types.Result.GetResult<Prisma.$WordDetailPayload<ExtArgs>, T, "findUnique", GlobalOmitOptions> | null, null, ExtArgs, GlobalOmitOptions>;
    findUniqueOrThrow<T extends WordDetailFindUniqueOrThrowArgs>(args: Prisma.SelectSubset<T, WordDetailFindUniqueOrThrowArgs<ExtArgs>>): Prisma.Prisma__WordDetailClient<runtime.Types.Result.GetResult<Prisma.$WordDetailPayload<ExtArgs>, T, "findUniqueOrThrow", GlobalOmitOptions>, never, ExtArgs, GlobalOmitOptions>;
    findFirst<T extends WordDetailFindFirstArgs>(args?: Prisma.SelectSubset<T, WordDetailFindFirstArgs<ExtArgs>>): Prisma.Prisma__WordDetailClient<runtime.Types.Result.GetResult<Prisma.$WordDetailPayload<ExtArgs>, T, "findFirst", GlobalOmitOptions> | null, null, ExtArgs, GlobalOmitOptions>;
    findFirstOrThrow<T extends WordDetailFindFirstOrThrowArgs>(args?: Prisma.SelectSubset<T, WordDetailFindFirstOrThrowArgs<ExtArgs>>): Prisma.Prisma__WordDetailClient<runtime.Types.Result.GetResult<Prisma.$WordDetailPayload<ExtArgs>, T, "findFirstOrThrow", GlobalOmitOptions>, never, ExtArgs, GlobalOmitOptions>;
    findMany<T extends WordDetailFindManyArgs>(args?: Prisma.SelectSubset<T, WordDetailFindManyArgs<ExtArgs>>): Prisma.PrismaPromise<runtime.Types.Result.GetResult<Prisma.$WordDetailPayload<ExtArgs>, T, "findMany", GlobalOmitOptions>>;
    create<T extends WordDetailCreateArgs>(args: Prisma.SelectSubset<T, WordDetailCreateArgs<ExtArgs>>): Prisma.Prisma__WordDetailClient<runtime.Types.Result.GetResult<Prisma.$WordDetailPayload<ExtArgs>, T, "create", GlobalOmitOptions>, never, ExtArgs, GlobalOmitOptions>;
    createMany<T extends WordDetailCreateManyArgs>(args?: Prisma.SelectSubset<T, WordDetailCreateManyArgs<ExtArgs>>): Prisma.PrismaPromise<Prisma.BatchPayload>;
    createManyAndReturn<T extends WordDetailCreateManyAndReturnArgs>(args?: Prisma.SelectSubset<T, WordDetailCreateManyAndReturnArgs<ExtArgs>>): Prisma.PrismaPromise<runtime.Types.Result.GetResult<Prisma.$WordDetailPayload<ExtArgs>, T, "createManyAndReturn", GlobalOmitOptions>>;
    delete<T extends WordDetailDeleteArgs>(args: Prisma.SelectSubset<T, WordDetailDeleteArgs<ExtArgs>>): Prisma.Prisma__WordDetailClient<runtime.Types.Result.GetResult<Prisma.$WordDetailPayload<ExtArgs>, T, "delete", GlobalOmitOptions>, never, ExtArgs, GlobalOmitOptions>;
    update<T extends WordDetailUpdateArgs>(args: Prisma.SelectSubset<T, WordDetailUpdateArgs<ExtArgs>>): Prisma.Prisma__WordDetailClient<runtime.Types.Result.GetResult<Prisma.$WordDetailPayload<ExtArgs>, T, "update", GlobalOmitOptions>, never, ExtArgs, GlobalOmitOptions>;
    deleteMany<T extends WordDetailDeleteManyArgs>(args?: Prisma.SelectSubset<T, WordDetailDeleteManyArgs<ExtArgs>>): Prisma.PrismaPromise<Prisma.BatchPayload>;
    updateMany<T extends WordDetailUpdateManyArgs>(args: Prisma.SelectSubset<T, WordDetailUpdateManyArgs<ExtArgs>>): Prisma.PrismaPromise<Prisma.BatchPayload>;
    updateManyAndReturn<T extends WordDetailUpdateManyAndReturnArgs>(args: Prisma.SelectSubset<T, WordDetailUpdateManyAndReturnArgs<ExtArgs>>): Prisma.PrismaPromise<runtime.Types.Result.GetResult<Prisma.$WordDetailPayload<ExtArgs>, T, "updateManyAndReturn", GlobalOmitOptions>>;
    upsert<T extends WordDetailUpsertArgs>(args: Prisma.SelectSubset<T, WordDetailUpsertArgs<ExtArgs>>): Prisma.Prisma__WordDetailClient<runtime.Types.Result.GetResult<Prisma.$WordDetailPayload<ExtArgs>, T, "upsert", GlobalOmitOptions>, never, ExtArgs, GlobalOmitOptions>;
    count<T extends WordDetailCountArgs>(args?: Prisma.Subset<T, WordDetailCountArgs>): Prisma.PrismaPromise<T extends runtime.Types.Utils.Record<'select', any> ? T['select'] extends true ? number : Prisma.GetScalarType<T['select'], WordDetailCountAggregateOutputType> : number>;
    aggregate<T extends WordDetailAggregateArgs>(args: Prisma.Subset<T, WordDetailAggregateArgs>): Prisma.PrismaPromise<GetWordDetailAggregateType<T>>;
    groupBy<T extends WordDetailGroupByArgs, HasSelectOrTake extends Prisma.Or<Prisma.Extends<'skip', Prisma.Keys<T>>, Prisma.Extends<'take', Prisma.Keys<T>>>, OrderByArg extends Prisma.True extends HasSelectOrTake ? {
        orderBy: WordDetailGroupByArgs['orderBy'];
    } : {
        orderBy?: WordDetailGroupByArgs['orderBy'];
    }, OrderFields extends Prisma.ExcludeUnderscoreKeys<Prisma.Keys<Prisma.MaybeTupleToUnion<T['orderBy']>>>, ByFields extends Prisma.MaybeTupleToUnion<T['by']>, ByValid extends Prisma.Has<ByFields, OrderFields>, HavingFields extends Prisma.GetHavingFields<T['having']>, HavingValid extends Prisma.Has<ByFields, HavingFields>, ByEmpty extends T['by'] extends never[] ? Prisma.True : Prisma.False, InputErrors extends ByEmpty extends Prisma.True ? `Error: "by" must not be empty.` : HavingValid extends Prisma.False ? {
        [P in HavingFields]: P extends ByFields ? never : P extends string ? `Error: Field "${P}" used in "having" needs to be provided in "by".` : [
            Error,
            'Field ',
            P,
            ` in "having" needs to be provided in "by"`
        ];
    }[HavingFields] : 'take' extends Prisma.Keys<T> ? 'orderBy' extends Prisma.Keys<T> ? ByValid extends Prisma.True ? {} : {
        [P in OrderFields]: P extends ByFields ? never : `Error: Field "${P}" in "orderBy" needs to be provided in "by"`;
    }[OrderFields] : 'Error: If you provide "take", you also need to provide "orderBy"' : 'skip' extends Prisma.Keys<T> ? 'orderBy' extends Prisma.Keys<T> ? ByValid extends Prisma.True ? {} : {
        [P in OrderFields]: P extends ByFields ? never : `Error: Field "${P}" in "orderBy" needs to be provided in "by"`;
    }[OrderFields] : 'Error: If you provide "skip", you also need to provide "orderBy"' : ByValid extends Prisma.True ? {} : {
        [P in OrderFields]: P extends ByFields ? never : `Error: Field "${P}" in "orderBy" needs to be provided in "by"`;
    }[OrderFields]>(args: Prisma.SubsetIntersection<T, WordDetailGroupByArgs, OrderByArg> & InputErrors): {} extends InputErrors ? GetWordDetailGroupByPayload<T> : Prisma.PrismaPromise<InputErrors>;
    readonly fields: WordDetailFieldRefs;
}
export interface Prisma__WordDetailClient<T, Null = never, ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs, GlobalOmitOptions = {}> extends Prisma.PrismaPromise<T> {
    readonly [Symbol.toStringTag]: "PrismaPromise";
    word<T extends Prisma.WordDefaultArgs<ExtArgs> = {}>(args?: Prisma.Subset<T, Prisma.WordDefaultArgs<ExtArgs>>): Prisma.Prisma__WordClient<runtime.Types.Result.GetResult<Prisma.$WordPayload<ExtArgs>, T, "findUniqueOrThrow", GlobalOmitOptions> | Null, Null, ExtArgs, GlobalOmitOptions>;
    then<TResult1 = T, TResult2 = never>(onfulfilled?: ((value: T) => TResult1 | PromiseLike<TResult1>) | undefined | null, onrejected?: ((reason: any) => TResult2 | PromiseLike<TResult2>) | undefined | null): runtime.Types.Utils.JsPromise<TResult1 | TResult2>;
    catch<TResult = never>(onrejected?: ((reason: any) => TResult | PromiseLike<TResult>) | undefined | null): runtime.Types.Utils.JsPromise<T | TResult>;
    finally(onfinally?: (() => void) | undefined | null): runtime.Types.Utils.JsPromise<T>;
}
export interface WordDetailFieldRefs {
    readonly id: Prisma.FieldRef<"WordDetail", 'String'>;
    readonly wordId: Prisma.FieldRef<"WordDetail", 'String'>;
    readonly korean: Prisma.FieldRef<"WordDetail", 'String'>;
    readonly romanisation: Prisma.FieldRef<"WordDetail", 'String'>;
    readonly translation: Prisma.FieldRef<"WordDetail", 'String'>;
    readonly grammaticalType: Prisma.FieldRef<"WordDetail", 'String'>;
    readonly exampleSentence: Prisma.FieldRef<"WordDetail", 'String'>;
}
export type WordDetailFindUniqueArgs<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs> = {
    select?: Prisma.WordDetailSelect<ExtArgs> | null;
    omit?: Prisma.WordDetailOmit<ExtArgs> | null;
    include?: Prisma.WordDetailInclude<ExtArgs> | null;
    where: Prisma.WordDetailWhereUniqueInput;
};
export type WordDetailFindUniqueOrThrowArgs<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs> = {
    select?: Prisma.WordDetailSelect<ExtArgs> | null;
    omit?: Prisma.WordDetailOmit<ExtArgs> | null;
    include?: Prisma.WordDetailInclude<ExtArgs> | null;
    where: Prisma.WordDetailWhereUniqueInput;
};
export type WordDetailFindFirstArgs<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs> = {
    select?: Prisma.WordDetailSelect<ExtArgs> | null;
    omit?: Prisma.WordDetailOmit<ExtArgs> | null;
    include?: Prisma.WordDetailInclude<ExtArgs> | null;
    where?: Prisma.WordDetailWhereInput;
    orderBy?: Prisma.WordDetailOrderByWithRelationInput | Prisma.WordDetailOrderByWithRelationInput[];
    cursor?: Prisma.WordDetailWhereUniqueInput;
    take?: number;
    skip?: number;
    distinct?: Prisma.WordDetailScalarFieldEnum | Prisma.WordDetailScalarFieldEnum[];
};
export type WordDetailFindFirstOrThrowArgs<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs> = {
    select?: Prisma.WordDetailSelect<ExtArgs> | null;
    omit?: Prisma.WordDetailOmit<ExtArgs> | null;
    include?: Prisma.WordDetailInclude<ExtArgs> | null;
    where?: Prisma.WordDetailWhereInput;
    orderBy?: Prisma.WordDetailOrderByWithRelationInput | Prisma.WordDetailOrderByWithRelationInput[];
    cursor?: Prisma.WordDetailWhereUniqueInput;
    take?: number;
    skip?: number;
    distinct?: Prisma.WordDetailScalarFieldEnum | Prisma.WordDetailScalarFieldEnum[];
};
export type WordDetailFindManyArgs<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs> = {
    select?: Prisma.WordDetailSelect<ExtArgs> | null;
    omit?: Prisma.WordDetailOmit<ExtArgs> | null;
    include?: Prisma.WordDetailInclude<ExtArgs> | null;
    where?: Prisma.WordDetailWhereInput;
    orderBy?: Prisma.WordDetailOrderByWithRelationInput | Prisma.WordDetailOrderByWithRelationInput[];
    cursor?: Prisma.WordDetailWhereUniqueInput;
    take?: number;
    skip?: number;
    distinct?: Prisma.WordDetailScalarFieldEnum | Prisma.WordDetailScalarFieldEnum[];
};
export type WordDetailCreateArgs<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs> = {
    select?: Prisma.WordDetailSelect<ExtArgs> | null;
    omit?: Prisma.WordDetailOmit<ExtArgs> | null;
    include?: Prisma.WordDetailInclude<ExtArgs> | null;
    data: Prisma.XOR<Prisma.WordDetailCreateInput, Prisma.WordDetailUncheckedCreateInput>;
};
export type WordDetailCreateManyArgs<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs> = {
    data: Prisma.WordDetailCreateManyInput | Prisma.WordDetailCreateManyInput[];
    skipDuplicates?: boolean;
};
export type WordDetailCreateManyAndReturnArgs<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs> = {
    select?: Prisma.WordDetailSelectCreateManyAndReturn<ExtArgs> | null;
    omit?: Prisma.WordDetailOmit<ExtArgs> | null;
    data: Prisma.WordDetailCreateManyInput | Prisma.WordDetailCreateManyInput[];
    skipDuplicates?: boolean;
    include?: Prisma.WordDetailIncludeCreateManyAndReturn<ExtArgs> | null;
};
export type WordDetailUpdateArgs<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs> = {
    select?: Prisma.WordDetailSelect<ExtArgs> | null;
    omit?: Prisma.WordDetailOmit<ExtArgs> | null;
    include?: Prisma.WordDetailInclude<ExtArgs> | null;
    data: Prisma.XOR<Prisma.WordDetailUpdateInput, Prisma.WordDetailUncheckedUpdateInput>;
    where: Prisma.WordDetailWhereUniqueInput;
};
export type WordDetailUpdateManyArgs<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs> = {
    data: Prisma.XOR<Prisma.WordDetailUpdateManyMutationInput, Prisma.WordDetailUncheckedUpdateManyInput>;
    where?: Prisma.WordDetailWhereInput;
    limit?: number;
};
export type WordDetailUpdateManyAndReturnArgs<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs> = {
    select?: Prisma.WordDetailSelectUpdateManyAndReturn<ExtArgs> | null;
    omit?: Prisma.WordDetailOmit<ExtArgs> | null;
    data: Prisma.XOR<Prisma.WordDetailUpdateManyMutationInput, Prisma.WordDetailUncheckedUpdateManyInput>;
    where?: Prisma.WordDetailWhereInput;
    limit?: number;
    include?: Prisma.WordDetailIncludeUpdateManyAndReturn<ExtArgs> | null;
};
export type WordDetailUpsertArgs<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs> = {
    select?: Prisma.WordDetailSelect<ExtArgs> | null;
    omit?: Prisma.WordDetailOmit<ExtArgs> | null;
    include?: Prisma.WordDetailInclude<ExtArgs> | null;
    where: Prisma.WordDetailWhereUniqueInput;
    create: Prisma.XOR<Prisma.WordDetailCreateInput, Prisma.WordDetailUncheckedCreateInput>;
    update: Prisma.XOR<Prisma.WordDetailUpdateInput, Prisma.WordDetailUncheckedUpdateInput>;
};
export type WordDetailDeleteArgs<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs> = {
    select?: Prisma.WordDetailSelect<ExtArgs> | null;
    omit?: Prisma.WordDetailOmit<ExtArgs> | null;
    include?: Prisma.WordDetailInclude<ExtArgs> | null;
    where: Prisma.WordDetailWhereUniqueInput;
};
export type WordDetailDeleteManyArgs<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs> = {
    where?: Prisma.WordDetailWhereInput;
    limit?: number;
};
export type WordDetailDefaultArgs<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs> = {
    select?: Prisma.WordDetailSelect<ExtArgs> | null;
    omit?: Prisma.WordDetailOmit<ExtArgs> | null;
    include?: Prisma.WordDetailInclude<ExtArgs> | null;
};
export {};
