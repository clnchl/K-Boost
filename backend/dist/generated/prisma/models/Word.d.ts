import type * as runtime from "@prisma/client/runtime/library";
import type * as Prisma from "../internal/prismaNamespace.js";
export type WordModel = runtime.Types.Result.DefaultSelection<Prisma.$WordPayload>;
export type AggregateWord = {
    _count: WordCountAggregateOutputType | null;
    _min: WordMinAggregateOutputType | null;
    _max: WordMaxAggregateOutputType | null;
};
export type WordMinAggregateOutputType = {
    id: string | null;
    korean: string | null;
    romanisation: string | null;
    translation: string | null;
    categoryId: string | null;
};
export type WordMaxAggregateOutputType = {
    id: string | null;
    korean: string | null;
    romanisation: string | null;
    translation: string | null;
    categoryId: string | null;
};
export type WordCountAggregateOutputType = {
    id: number;
    korean: number;
    romanisation: number;
    translation: number;
    categoryId: number;
    _all: number;
};
export type WordMinAggregateInputType = {
    id?: true;
    korean?: true;
    romanisation?: true;
    translation?: true;
    categoryId?: true;
};
export type WordMaxAggregateInputType = {
    id?: true;
    korean?: true;
    romanisation?: true;
    translation?: true;
    categoryId?: true;
};
export type WordCountAggregateInputType = {
    id?: true;
    korean?: true;
    romanisation?: true;
    translation?: true;
    categoryId?: true;
    _all?: true;
};
export type WordAggregateArgs<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs> = {
    where?: Prisma.WordWhereInput;
    orderBy?: Prisma.WordOrderByWithRelationInput | Prisma.WordOrderByWithRelationInput[];
    cursor?: Prisma.WordWhereUniqueInput;
    take?: number;
    skip?: number;
    _count?: true | WordCountAggregateInputType;
    _min?: WordMinAggregateInputType;
    _max?: WordMaxAggregateInputType;
};
export type GetWordAggregateType<T extends WordAggregateArgs> = {
    [P in keyof T & keyof AggregateWord]: P extends '_count' | 'count' ? T[P] extends true ? number : Prisma.GetScalarType<T[P], AggregateWord[P]> : Prisma.GetScalarType<T[P], AggregateWord[P]>;
};
export type WordGroupByArgs<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs> = {
    where?: Prisma.WordWhereInput;
    orderBy?: Prisma.WordOrderByWithAggregationInput | Prisma.WordOrderByWithAggregationInput[];
    by: Prisma.WordScalarFieldEnum[] | Prisma.WordScalarFieldEnum;
    having?: Prisma.WordScalarWhereWithAggregatesInput;
    take?: number;
    skip?: number;
    _count?: WordCountAggregateInputType | true;
    _min?: WordMinAggregateInputType;
    _max?: WordMaxAggregateInputType;
};
export type WordGroupByOutputType = {
    id: string;
    korean: string;
    romanisation: string;
    translation: string;
    categoryId: string;
    _count: WordCountAggregateOutputType | null;
    _min: WordMinAggregateOutputType | null;
    _max: WordMaxAggregateOutputType | null;
};
type GetWordGroupByPayload<T extends WordGroupByArgs> = Prisma.PrismaPromise<Array<Prisma.PickEnumerable<WordGroupByOutputType, T['by']> & {
    [P in ((keyof T) & (keyof WordGroupByOutputType))]: P extends '_count' ? T[P] extends boolean ? number : Prisma.GetScalarType<T[P], WordGroupByOutputType[P]> : Prisma.GetScalarType<T[P], WordGroupByOutputType[P]>;
}>>;
export type WordWhereInput = {
    AND?: Prisma.WordWhereInput | Prisma.WordWhereInput[];
    OR?: Prisma.WordWhereInput[];
    NOT?: Prisma.WordWhereInput | Prisma.WordWhereInput[];
    id?: Prisma.StringFilter<"Word"> | string;
    korean?: Prisma.StringFilter<"Word"> | string;
    romanisation?: Prisma.StringFilter<"Word"> | string;
    translation?: Prisma.StringFilter<"Word"> | string;
    categoryId?: Prisma.StringFilter<"Word"> | string;
    category?: Prisma.XOR<Prisma.CategoryScalarRelationFilter, Prisma.CategoryWhereInput>;
    detail?: Prisma.XOR<Prisma.WordDetailNullableScalarRelationFilter, Prisma.WordDetailWhereInput> | null;
};
export type WordOrderByWithRelationInput = {
    id?: Prisma.SortOrder;
    korean?: Prisma.SortOrder;
    romanisation?: Prisma.SortOrder;
    translation?: Prisma.SortOrder;
    categoryId?: Prisma.SortOrder;
    category?: Prisma.CategoryOrderByWithRelationInput;
    detail?: Prisma.WordDetailOrderByWithRelationInput;
};
export type WordWhereUniqueInput = Prisma.AtLeast<{
    id?: string;
    AND?: Prisma.WordWhereInput | Prisma.WordWhereInput[];
    OR?: Prisma.WordWhereInput[];
    NOT?: Prisma.WordWhereInput | Prisma.WordWhereInput[];
    korean?: Prisma.StringFilter<"Word"> | string;
    romanisation?: Prisma.StringFilter<"Word"> | string;
    translation?: Prisma.StringFilter<"Word"> | string;
    categoryId?: Prisma.StringFilter<"Word"> | string;
    category?: Prisma.XOR<Prisma.CategoryScalarRelationFilter, Prisma.CategoryWhereInput>;
    detail?: Prisma.XOR<Prisma.WordDetailNullableScalarRelationFilter, Prisma.WordDetailWhereInput> | null;
}, "id">;
export type WordOrderByWithAggregationInput = {
    id?: Prisma.SortOrder;
    korean?: Prisma.SortOrder;
    romanisation?: Prisma.SortOrder;
    translation?: Prisma.SortOrder;
    categoryId?: Prisma.SortOrder;
    _count?: Prisma.WordCountOrderByAggregateInput;
    _max?: Prisma.WordMaxOrderByAggregateInput;
    _min?: Prisma.WordMinOrderByAggregateInput;
};
export type WordScalarWhereWithAggregatesInput = {
    AND?: Prisma.WordScalarWhereWithAggregatesInput | Prisma.WordScalarWhereWithAggregatesInput[];
    OR?: Prisma.WordScalarWhereWithAggregatesInput[];
    NOT?: Prisma.WordScalarWhereWithAggregatesInput | Prisma.WordScalarWhereWithAggregatesInput[];
    id?: Prisma.StringWithAggregatesFilter<"Word"> | string;
    korean?: Prisma.StringWithAggregatesFilter<"Word"> | string;
    romanisation?: Prisma.StringWithAggregatesFilter<"Word"> | string;
    translation?: Prisma.StringWithAggregatesFilter<"Word"> | string;
    categoryId?: Prisma.StringWithAggregatesFilter<"Word"> | string;
};
export type WordCreateInput = {
    id: string;
    korean: string;
    romanisation: string;
    translation: string;
    category: Prisma.CategoryCreateNestedOneWithoutWordsInput;
    detail?: Prisma.WordDetailCreateNestedOneWithoutWordInput;
};
export type WordUncheckedCreateInput = {
    id: string;
    korean: string;
    romanisation: string;
    translation: string;
    categoryId: string;
    detail?: Prisma.WordDetailUncheckedCreateNestedOneWithoutWordInput;
};
export type WordUpdateInput = {
    id?: Prisma.StringFieldUpdateOperationsInput | string;
    korean?: Prisma.StringFieldUpdateOperationsInput | string;
    romanisation?: Prisma.StringFieldUpdateOperationsInput | string;
    translation?: Prisma.StringFieldUpdateOperationsInput | string;
    category?: Prisma.CategoryUpdateOneRequiredWithoutWordsNestedInput;
    detail?: Prisma.WordDetailUpdateOneWithoutWordNestedInput;
};
export type WordUncheckedUpdateInput = {
    id?: Prisma.StringFieldUpdateOperationsInput | string;
    korean?: Prisma.StringFieldUpdateOperationsInput | string;
    romanisation?: Prisma.StringFieldUpdateOperationsInput | string;
    translation?: Prisma.StringFieldUpdateOperationsInput | string;
    categoryId?: Prisma.StringFieldUpdateOperationsInput | string;
    detail?: Prisma.WordDetailUncheckedUpdateOneWithoutWordNestedInput;
};
export type WordCreateManyInput = {
    id: string;
    korean: string;
    romanisation: string;
    translation: string;
    categoryId: string;
};
export type WordUpdateManyMutationInput = {
    id?: Prisma.StringFieldUpdateOperationsInput | string;
    korean?: Prisma.StringFieldUpdateOperationsInput | string;
    romanisation?: Prisma.StringFieldUpdateOperationsInput | string;
    translation?: Prisma.StringFieldUpdateOperationsInput | string;
};
export type WordUncheckedUpdateManyInput = {
    id?: Prisma.StringFieldUpdateOperationsInput | string;
    korean?: Prisma.StringFieldUpdateOperationsInput | string;
    romanisation?: Prisma.StringFieldUpdateOperationsInput | string;
    translation?: Prisma.StringFieldUpdateOperationsInput | string;
    categoryId?: Prisma.StringFieldUpdateOperationsInput | string;
};
export type WordListRelationFilter = {
    every?: Prisma.WordWhereInput;
    some?: Prisma.WordWhereInput;
    none?: Prisma.WordWhereInput;
};
export type WordOrderByRelationAggregateInput = {
    _count?: Prisma.SortOrder;
};
export type WordCountOrderByAggregateInput = {
    id?: Prisma.SortOrder;
    korean?: Prisma.SortOrder;
    romanisation?: Prisma.SortOrder;
    translation?: Prisma.SortOrder;
    categoryId?: Prisma.SortOrder;
};
export type WordMaxOrderByAggregateInput = {
    id?: Prisma.SortOrder;
    korean?: Prisma.SortOrder;
    romanisation?: Prisma.SortOrder;
    translation?: Prisma.SortOrder;
    categoryId?: Prisma.SortOrder;
};
export type WordMinOrderByAggregateInput = {
    id?: Prisma.SortOrder;
    korean?: Prisma.SortOrder;
    romanisation?: Prisma.SortOrder;
    translation?: Prisma.SortOrder;
    categoryId?: Prisma.SortOrder;
};
export type WordScalarRelationFilter = {
    is?: Prisma.WordWhereInput;
    isNot?: Prisma.WordWhereInput;
};
export type WordCreateNestedManyWithoutCategoryInput = {
    create?: Prisma.XOR<Prisma.WordCreateWithoutCategoryInput, Prisma.WordUncheckedCreateWithoutCategoryInput> | Prisma.WordCreateWithoutCategoryInput[] | Prisma.WordUncheckedCreateWithoutCategoryInput[];
    connectOrCreate?: Prisma.WordCreateOrConnectWithoutCategoryInput | Prisma.WordCreateOrConnectWithoutCategoryInput[];
    createMany?: Prisma.WordCreateManyCategoryInputEnvelope;
    connect?: Prisma.WordWhereUniqueInput | Prisma.WordWhereUniqueInput[];
};
export type WordUncheckedCreateNestedManyWithoutCategoryInput = {
    create?: Prisma.XOR<Prisma.WordCreateWithoutCategoryInput, Prisma.WordUncheckedCreateWithoutCategoryInput> | Prisma.WordCreateWithoutCategoryInput[] | Prisma.WordUncheckedCreateWithoutCategoryInput[];
    connectOrCreate?: Prisma.WordCreateOrConnectWithoutCategoryInput | Prisma.WordCreateOrConnectWithoutCategoryInput[];
    createMany?: Prisma.WordCreateManyCategoryInputEnvelope;
    connect?: Prisma.WordWhereUniqueInput | Prisma.WordWhereUniqueInput[];
};
export type WordUpdateManyWithoutCategoryNestedInput = {
    create?: Prisma.XOR<Prisma.WordCreateWithoutCategoryInput, Prisma.WordUncheckedCreateWithoutCategoryInput> | Prisma.WordCreateWithoutCategoryInput[] | Prisma.WordUncheckedCreateWithoutCategoryInput[];
    connectOrCreate?: Prisma.WordCreateOrConnectWithoutCategoryInput | Prisma.WordCreateOrConnectWithoutCategoryInput[];
    upsert?: Prisma.WordUpsertWithWhereUniqueWithoutCategoryInput | Prisma.WordUpsertWithWhereUniqueWithoutCategoryInput[];
    createMany?: Prisma.WordCreateManyCategoryInputEnvelope;
    set?: Prisma.WordWhereUniqueInput | Prisma.WordWhereUniqueInput[];
    disconnect?: Prisma.WordWhereUniqueInput | Prisma.WordWhereUniqueInput[];
    delete?: Prisma.WordWhereUniqueInput | Prisma.WordWhereUniqueInput[];
    connect?: Prisma.WordWhereUniqueInput | Prisma.WordWhereUniqueInput[];
    update?: Prisma.WordUpdateWithWhereUniqueWithoutCategoryInput | Prisma.WordUpdateWithWhereUniqueWithoutCategoryInput[];
    updateMany?: Prisma.WordUpdateManyWithWhereWithoutCategoryInput | Prisma.WordUpdateManyWithWhereWithoutCategoryInput[];
    deleteMany?: Prisma.WordScalarWhereInput | Prisma.WordScalarWhereInput[];
};
export type WordUncheckedUpdateManyWithoutCategoryNestedInput = {
    create?: Prisma.XOR<Prisma.WordCreateWithoutCategoryInput, Prisma.WordUncheckedCreateWithoutCategoryInput> | Prisma.WordCreateWithoutCategoryInput[] | Prisma.WordUncheckedCreateWithoutCategoryInput[];
    connectOrCreate?: Prisma.WordCreateOrConnectWithoutCategoryInput | Prisma.WordCreateOrConnectWithoutCategoryInput[];
    upsert?: Prisma.WordUpsertWithWhereUniqueWithoutCategoryInput | Prisma.WordUpsertWithWhereUniqueWithoutCategoryInput[];
    createMany?: Prisma.WordCreateManyCategoryInputEnvelope;
    set?: Prisma.WordWhereUniqueInput | Prisma.WordWhereUniqueInput[];
    disconnect?: Prisma.WordWhereUniqueInput | Prisma.WordWhereUniqueInput[];
    delete?: Prisma.WordWhereUniqueInput | Prisma.WordWhereUniqueInput[];
    connect?: Prisma.WordWhereUniqueInput | Prisma.WordWhereUniqueInput[];
    update?: Prisma.WordUpdateWithWhereUniqueWithoutCategoryInput | Prisma.WordUpdateWithWhereUniqueWithoutCategoryInput[];
    updateMany?: Prisma.WordUpdateManyWithWhereWithoutCategoryInput | Prisma.WordUpdateManyWithWhereWithoutCategoryInput[];
    deleteMany?: Prisma.WordScalarWhereInput | Prisma.WordScalarWhereInput[];
};
export type WordCreateNestedOneWithoutDetailInput = {
    create?: Prisma.XOR<Prisma.WordCreateWithoutDetailInput, Prisma.WordUncheckedCreateWithoutDetailInput>;
    connectOrCreate?: Prisma.WordCreateOrConnectWithoutDetailInput;
    connect?: Prisma.WordWhereUniqueInput;
};
export type WordUpdateOneRequiredWithoutDetailNestedInput = {
    create?: Prisma.XOR<Prisma.WordCreateWithoutDetailInput, Prisma.WordUncheckedCreateWithoutDetailInput>;
    connectOrCreate?: Prisma.WordCreateOrConnectWithoutDetailInput;
    upsert?: Prisma.WordUpsertWithoutDetailInput;
    connect?: Prisma.WordWhereUniqueInput;
    update?: Prisma.XOR<Prisma.XOR<Prisma.WordUpdateToOneWithWhereWithoutDetailInput, Prisma.WordUpdateWithoutDetailInput>, Prisma.WordUncheckedUpdateWithoutDetailInput>;
};
export type WordCreateWithoutCategoryInput = {
    id: string;
    korean: string;
    romanisation: string;
    translation: string;
    detail?: Prisma.WordDetailCreateNestedOneWithoutWordInput;
};
export type WordUncheckedCreateWithoutCategoryInput = {
    id: string;
    korean: string;
    romanisation: string;
    translation: string;
    detail?: Prisma.WordDetailUncheckedCreateNestedOneWithoutWordInput;
};
export type WordCreateOrConnectWithoutCategoryInput = {
    where: Prisma.WordWhereUniqueInput;
    create: Prisma.XOR<Prisma.WordCreateWithoutCategoryInput, Prisma.WordUncheckedCreateWithoutCategoryInput>;
};
export type WordCreateManyCategoryInputEnvelope = {
    data: Prisma.WordCreateManyCategoryInput | Prisma.WordCreateManyCategoryInput[];
    skipDuplicates?: boolean;
};
export type WordUpsertWithWhereUniqueWithoutCategoryInput = {
    where: Prisma.WordWhereUniqueInput;
    update: Prisma.XOR<Prisma.WordUpdateWithoutCategoryInput, Prisma.WordUncheckedUpdateWithoutCategoryInput>;
    create: Prisma.XOR<Prisma.WordCreateWithoutCategoryInput, Prisma.WordUncheckedCreateWithoutCategoryInput>;
};
export type WordUpdateWithWhereUniqueWithoutCategoryInput = {
    where: Prisma.WordWhereUniqueInput;
    data: Prisma.XOR<Prisma.WordUpdateWithoutCategoryInput, Prisma.WordUncheckedUpdateWithoutCategoryInput>;
};
export type WordUpdateManyWithWhereWithoutCategoryInput = {
    where: Prisma.WordScalarWhereInput;
    data: Prisma.XOR<Prisma.WordUpdateManyMutationInput, Prisma.WordUncheckedUpdateManyWithoutCategoryInput>;
};
export type WordScalarWhereInput = {
    AND?: Prisma.WordScalarWhereInput | Prisma.WordScalarWhereInput[];
    OR?: Prisma.WordScalarWhereInput[];
    NOT?: Prisma.WordScalarWhereInput | Prisma.WordScalarWhereInput[];
    id?: Prisma.StringFilter<"Word"> | string;
    korean?: Prisma.StringFilter<"Word"> | string;
    romanisation?: Prisma.StringFilter<"Word"> | string;
    translation?: Prisma.StringFilter<"Word"> | string;
    categoryId?: Prisma.StringFilter<"Word"> | string;
};
export type WordCreateWithoutDetailInput = {
    id: string;
    korean: string;
    romanisation: string;
    translation: string;
    category: Prisma.CategoryCreateNestedOneWithoutWordsInput;
};
export type WordUncheckedCreateWithoutDetailInput = {
    id: string;
    korean: string;
    romanisation: string;
    translation: string;
    categoryId: string;
};
export type WordCreateOrConnectWithoutDetailInput = {
    where: Prisma.WordWhereUniqueInput;
    create: Prisma.XOR<Prisma.WordCreateWithoutDetailInput, Prisma.WordUncheckedCreateWithoutDetailInput>;
};
export type WordUpsertWithoutDetailInput = {
    update: Prisma.XOR<Prisma.WordUpdateWithoutDetailInput, Prisma.WordUncheckedUpdateWithoutDetailInput>;
    create: Prisma.XOR<Prisma.WordCreateWithoutDetailInput, Prisma.WordUncheckedCreateWithoutDetailInput>;
    where?: Prisma.WordWhereInput;
};
export type WordUpdateToOneWithWhereWithoutDetailInput = {
    where?: Prisma.WordWhereInput;
    data: Prisma.XOR<Prisma.WordUpdateWithoutDetailInput, Prisma.WordUncheckedUpdateWithoutDetailInput>;
};
export type WordUpdateWithoutDetailInput = {
    id?: Prisma.StringFieldUpdateOperationsInput | string;
    korean?: Prisma.StringFieldUpdateOperationsInput | string;
    romanisation?: Prisma.StringFieldUpdateOperationsInput | string;
    translation?: Prisma.StringFieldUpdateOperationsInput | string;
    category?: Prisma.CategoryUpdateOneRequiredWithoutWordsNestedInput;
};
export type WordUncheckedUpdateWithoutDetailInput = {
    id?: Prisma.StringFieldUpdateOperationsInput | string;
    korean?: Prisma.StringFieldUpdateOperationsInput | string;
    romanisation?: Prisma.StringFieldUpdateOperationsInput | string;
    translation?: Prisma.StringFieldUpdateOperationsInput | string;
    categoryId?: Prisma.StringFieldUpdateOperationsInput | string;
};
export type WordCreateManyCategoryInput = {
    id: string;
    korean: string;
    romanisation: string;
    translation: string;
};
export type WordUpdateWithoutCategoryInput = {
    id?: Prisma.StringFieldUpdateOperationsInput | string;
    korean?: Prisma.StringFieldUpdateOperationsInput | string;
    romanisation?: Prisma.StringFieldUpdateOperationsInput | string;
    translation?: Prisma.StringFieldUpdateOperationsInput | string;
    detail?: Prisma.WordDetailUpdateOneWithoutWordNestedInput;
};
export type WordUncheckedUpdateWithoutCategoryInput = {
    id?: Prisma.StringFieldUpdateOperationsInput | string;
    korean?: Prisma.StringFieldUpdateOperationsInput | string;
    romanisation?: Prisma.StringFieldUpdateOperationsInput | string;
    translation?: Prisma.StringFieldUpdateOperationsInput | string;
    detail?: Prisma.WordDetailUncheckedUpdateOneWithoutWordNestedInput;
};
export type WordUncheckedUpdateManyWithoutCategoryInput = {
    id?: Prisma.StringFieldUpdateOperationsInput | string;
    korean?: Prisma.StringFieldUpdateOperationsInput | string;
    romanisation?: Prisma.StringFieldUpdateOperationsInput | string;
    translation?: Prisma.StringFieldUpdateOperationsInput | string;
};
export type WordSelect<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs> = runtime.Types.Extensions.GetSelect<{
    id?: boolean;
    korean?: boolean;
    romanisation?: boolean;
    translation?: boolean;
    categoryId?: boolean;
    category?: boolean | Prisma.CategoryDefaultArgs<ExtArgs>;
    detail?: boolean | Prisma.Word$detailArgs<ExtArgs>;
}, ExtArgs["result"]["word"]>;
export type WordSelectCreateManyAndReturn<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs> = runtime.Types.Extensions.GetSelect<{
    id?: boolean;
    korean?: boolean;
    romanisation?: boolean;
    translation?: boolean;
    categoryId?: boolean;
    category?: boolean | Prisma.CategoryDefaultArgs<ExtArgs>;
}, ExtArgs["result"]["word"]>;
export type WordSelectUpdateManyAndReturn<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs> = runtime.Types.Extensions.GetSelect<{
    id?: boolean;
    korean?: boolean;
    romanisation?: boolean;
    translation?: boolean;
    categoryId?: boolean;
    category?: boolean | Prisma.CategoryDefaultArgs<ExtArgs>;
}, ExtArgs["result"]["word"]>;
export type WordSelectScalar = {
    id?: boolean;
    korean?: boolean;
    romanisation?: boolean;
    translation?: boolean;
    categoryId?: boolean;
};
export type WordOmit<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs> = runtime.Types.Extensions.GetOmit<"id" | "korean" | "romanisation" | "translation" | "categoryId", ExtArgs["result"]["word"]>;
export type WordInclude<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs> = {
    category?: boolean | Prisma.CategoryDefaultArgs<ExtArgs>;
    detail?: boolean | Prisma.Word$detailArgs<ExtArgs>;
};
export type WordIncludeCreateManyAndReturn<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs> = {
    category?: boolean | Prisma.CategoryDefaultArgs<ExtArgs>;
};
export type WordIncludeUpdateManyAndReturn<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs> = {
    category?: boolean | Prisma.CategoryDefaultArgs<ExtArgs>;
};
export type $WordPayload<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs> = {
    name: "Word";
    objects: {
        category: Prisma.$CategoryPayload<ExtArgs>;
        detail: Prisma.$WordDetailPayload<ExtArgs> | null;
    };
    scalars: runtime.Types.Extensions.GetPayloadResult<{
        id: string;
        korean: string;
        romanisation: string;
        translation: string;
        categoryId: string;
    }, ExtArgs["result"]["word"]>;
    composites: {};
};
export type WordGetPayload<S extends boolean | null | undefined | WordDefaultArgs> = runtime.Types.Result.GetResult<Prisma.$WordPayload, S>;
export type WordCountArgs<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs> = Omit<WordFindManyArgs, 'select' | 'include' | 'distinct' | 'omit'> & {
    select?: WordCountAggregateInputType | true;
};
export interface WordDelegate<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs, GlobalOmitOptions = {}> {
    [K: symbol]: {
        types: Prisma.TypeMap<ExtArgs>['model']['Word'];
        meta: {
            name: 'Word';
        };
    };
    findUnique<T extends WordFindUniqueArgs>(args: Prisma.SelectSubset<T, WordFindUniqueArgs<ExtArgs>>): Prisma.Prisma__WordClient<runtime.Types.Result.GetResult<Prisma.$WordPayload<ExtArgs>, T, "findUnique", GlobalOmitOptions> | null, null, ExtArgs, GlobalOmitOptions>;
    findUniqueOrThrow<T extends WordFindUniqueOrThrowArgs>(args: Prisma.SelectSubset<T, WordFindUniqueOrThrowArgs<ExtArgs>>): Prisma.Prisma__WordClient<runtime.Types.Result.GetResult<Prisma.$WordPayload<ExtArgs>, T, "findUniqueOrThrow", GlobalOmitOptions>, never, ExtArgs, GlobalOmitOptions>;
    findFirst<T extends WordFindFirstArgs>(args?: Prisma.SelectSubset<T, WordFindFirstArgs<ExtArgs>>): Prisma.Prisma__WordClient<runtime.Types.Result.GetResult<Prisma.$WordPayload<ExtArgs>, T, "findFirst", GlobalOmitOptions> | null, null, ExtArgs, GlobalOmitOptions>;
    findFirstOrThrow<T extends WordFindFirstOrThrowArgs>(args?: Prisma.SelectSubset<T, WordFindFirstOrThrowArgs<ExtArgs>>): Prisma.Prisma__WordClient<runtime.Types.Result.GetResult<Prisma.$WordPayload<ExtArgs>, T, "findFirstOrThrow", GlobalOmitOptions>, never, ExtArgs, GlobalOmitOptions>;
    findMany<T extends WordFindManyArgs>(args?: Prisma.SelectSubset<T, WordFindManyArgs<ExtArgs>>): Prisma.PrismaPromise<runtime.Types.Result.GetResult<Prisma.$WordPayload<ExtArgs>, T, "findMany", GlobalOmitOptions>>;
    create<T extends WordCreateArgs>(args: Prisma.SelectSubset<T, WordCreateArgs<ExtArgs>>): Prisma.Prisma__WordClient<runtime.Types.Result.GetResult<Prisma.$WordPayload<ExtArgs>, T, "create", GlobalOmitOptions>, never, ExtArgs, GlobalOmitOptions>;
    createMany<T extends WordCreateManyArgs>(args?: Prisma.SelectSubset<T, WordCreateManyArgs<ExtArgs>>): Prisma.PrismaPromise<Prisma.BatchPayload>;
    createManyAndReturn<T extends WordCreateManyAndReturnArgs>(args?: Prisma.SelectSubset<T, WordCreateManyAndReturnArgs<ExtArgs>>): Prisma.PrismaPromise<runtime.Types.Result.GetResult<Prisma.$WordPayload<ExtArgs>, T, "createManyAndReturn", GlobalOmitOptions>>;
    delete<T extends WordDeleteArgs>(args: Prisma.SelectSubset<T, WordDeleteArgs<ExtArgs>>): Prisma.Prisma__WordClient<runtime.Types.Result.GetResult<Prisma.$WordPayload<ExtArgs>, T, "delete", GlobalOmitOptions>, never, ExtArgs, GlobalOmitOptions>;
    update<T extends WordUpdateArgs>(args: Prisma.SelectSubset<T, WordUpdateArgs<ExtArgs>>): Prisma.Prisma__WordClient<runtime.Types.Result.GetResult<Prisma.$WordPayload<ExtArgs>, T, "update", GlobalOmitOptions>, never, ExtArgs, GlobalOmitOptions>;
    deleteMany<T extends WordDeleteManyArgs>(args?: Prisma.SelectSubset<T, WordDeleteManyArgs<ExtArgs>>): Prisma.PrismaPromise<Prisma.BatchPayload>;
    updateMany<T extends WordUpdateManyArgs>(args: Prisma.SelectSubset<T, WordUpdateManyArgs<ExtArgs>>): Prisma.PrismaPromise<Prisma.BatchPayload>;
    updateManyAndReturn<T extends WordUpdateManyAndReturnArgs>(args: Prisma.SelectSubset<T, WordUpdateManyAndReturnArgs<ExtArgs>>): Prisma.PrismaPromise<runtime.Types.Result.GetResult<Prisma.$WordPayload<ExtArgs>, T, "updateManyAndReturn", GlobalOmitOptions>>;
    upsert<T extends WordUpsertArgs>(args: Prisma.SelectSubset<T, WordUpsertArgs<ExtArgs>>): Prisma.Prisma__WordClient<runtime.Types.Result.GetResult<Prisma.$WordPayload<ExtArgs>, T, "upsert", GlobalOmitOptions>, never, ExtArgs, GlobalOmitOptions>;
    count<T extends WordCountArgs>(args?: Prisma.Subset<T, WordCountArgs>): Prisma.PrismaPromise<T extends runtime.Types.Utils.Record<'select', any> ? T['select'] extends true ? number : Prisma.GetScalarType<T['select'], WordCountAggregateOutputType> : number>;
    aggregate<T extends WordAggregateArgs>(args: Prisma.Subset<T, WordAggregateArgs>): Prisma.PrismaPromise<GetWordAggregateType<T>>;
    groupBy<T extends WordGroupByArgs, HasSelectOrTake extends Prisma.Or<Prisma.Extends<'skip', Prisma.Keys<T>>, Prisma.Extends<'take', Prisma.Keys<T>>>, OrderByArg extends Prisma.True extends HasSelectOrTake ? {
        orderBy: WordGroupByArgs['orderBy'];
    } : {
        orderBy?: WordGroupByArgs['orderBy'];
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
    }[OrderFields]>(args: Prisma.SubsetIntersection<T, WordGroupByArgs, OrderByArg> & InputErrors): {} extends InputErrors ? GetWordGroupByPayload<T> : Prisma.PrismaPromise<InputErrors>;
    readonly fields: WordFieldRefs;
}
export interface Prisma__WordClient<T, Null = never, ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs, GlobalOmitOptions = {}> extends Prisma.PrismaPromise<T> {
    readonly [Symbol.toStringTag]: "PrismaPromise";
    category<T extends Prisma.CategoryDefaultArgs<ExtArgs> = {}>(args?: Prisma.Subset<T, Prisma.CategoryDefaultArgs<ExtArgs>>): Prisma.Prisma__CategoryClient<runtime.Types.Result.GetResult<Prisma.$CategoryPayload<ExtArgs>, T, "findUniqueOrThrow", GlobalOmitOptions> | Null, Null, ExtArgs, GlobalOmitOptions>;
    detail<T extends Prisma.Word$detailArgs<ExtArgs> = {}>(args?: Prisma.Subset<T, Prisma.Word$detailArgs<ExtArgs>>): Prisma.Prisma__WordDetailClient<runtime.Types.Result.GetResult<Prisma.$WordDetailPayload<ExtArgs>, T, "findUniqueOrThrow", GlobalOmitOptions> | null, null, ExtArgs, GlobalOmitOptions>;
    then<TResult1 = T, TResult2 = never>(onfulfilled?: ((value: T) => TResult1 | PromiseLike<TResult1>) | undefined | null, onrejected?: ((reason: any) => TResult2 | PromiseLike<TResult2>) | undefined | null): runtime.Types.Utils.JsPromise<TResult1 | TResult2>;
    catch<TResult = never>(onrejected?: ((reason: any) => TResult | PromiseLike<TResult>) | undefined | null): runtime.Types.Utils.JsPromise<T | TResult>;
    finally(onfinally?: (() => void) | undefined | null): runtime.Types.Utils.JsPromise<T>;
}
export interface WordFieldRefs {
    readonly id: Prisma.FieldRef<"Word", 'String'>;
    readonly korean: Prisma.FieldRef<"Word", 'String'>;
    readonly romanisation: Prisma.FieldRef<"Word", 'String'>;
    readonly translation: Prisma.FieldRef<"Word", 'String'>;
    readonly categoryId: Prisma.FieldRef<"Word", 'String'>;
}
export type WordFindUniqueArgs<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs> = {
    select?: Prisma.WordSelect<ExtArgs> | null;
    omit?: Prisma.WordOmit<ExtArgs> | null;
    include?: Prisma.WordInclude<ExtArgs> | null;
    where: Prisma.WordWhereUniqueInput;
};
export type WordFindUniqueOrThrowArgs<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs> = {
    select?: Prisma.WordSelect<ExtArgs> | null;
    omit?: Prisma.WordOmit<ExtArgs> | null;
    include?: Prisma.WordInclude<ExtArgs> | null;
    where: Prisma.WordWhereUniqueInput;
};
export type WordFindFirstArgs<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs> = {
    select?: Prisma.WordSelect<ExtArgs> | null;
    omit?: Prisma.WordOmit<ExtArgs> | null;
    include?: Prisma.WordInclude<ExtArgs> | null;
    where?: Prisma.WordWhereInput;
    orderBy?: Prisma.WordOrderByWithRelationInput | Prisma.WordOrderByWithRelationInput[];
    cursor?: Prisma.WordWhereUniqueInput;
    take?: number;
    skip?: number;
    distinct?: Prisma.WordScalarFieldEnum | Prisma.WordScalarFieldEnum[];
};
export type WordFindFirstOrThrowArgs<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs> = {
    select?: Prisma.WordSelect<ExtArgs> | null;
    omit?: Prisma.WordOmit<ExtArgs> | null;
    include?: Prisma.WordInclude<ExtArgs> | null;
    where?: Prisma.WordWhereInput;
    orderBy?: Prisma.WordOrderByWithRelationInput | Prisma.WordOrderByWithRelationInput[];
    cursor?: Prisma.WordWhereUniqueInput;
    take?: number;
    skip?: number;
    distinct?: Prisma.WordScalarFieldEnum | Prisma.WordScalarFieldEnum[];
};
export type WordFindManyArgs<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs> = {
    select?: Prisma.WordSelect<ExtArgs> | null;
    omit?: Prisma.WordOmit<ExtArgs> | null;
    include?: Prisma.WordInclude<ExtArgs> | null;
    where?: Prisma.WordWhereInput;
    orderBy?: Prisma.WordOrderByWithRelationInput | Prisma.WordOrderByWithRelationInput[];
    cursor?: Prisma.WordWhereUniqueInput;
    take?: number;
    skip?: number;
    distinct?: Prisma.WordScalarFieldEnum | Prisma.WordScalarFieldEnum[];
};
export type WordCreateArgs<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs> = {
    select?: Prisma.WordSelect<ExtArgs> | null;
    omit?: Prisma.WordOmit<ExtArgs> | null;
    include?: Prisma.WordInclude<ExtArgs> | null;
    data: Prisma.XOR<Prisma.WordCreateInput, Prisma.WordUncheckedCreateInput>;
};
export type WordCreateManyArgs<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs> = {
    data: Prisma.WordCreateManyInput | Prisma.WordCreateManyInput[];
    skipDuplicates?: boolean;
};
export type WordCreateManyAndReturnArgs<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs> = {
    select?: Prisma.WordSelectCreateManyAndReturn<ExtArgs> | null;
    omit?: Prisma.WordOmit<ExtArgs> | null;
    data: Prisma.WordCreateManyInput | Prisma.WordCreateManyInput[];
    skipDuplicates?: boolean;
    include?: Prisma.WordIncludeCreateManyAndReturn<ExtArgs> | null;
};
export type WordUpdateArgs<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs> = {
    select?: Prisma.WordSelect<ExtArgs> | null;
    omit?: Prisma.WordOmit<ExtArgs> | null;
    include?: Prisma.WordInclude<ExtArgs> | null;
    data: Prisma.XOR<Prisma.WordUpdateInput, Prisma.WordUncheckedUpdateInput>;
    where: Prisma.WordWhereUniqueInput;
};
export type WordUpdateManyArgs<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs> = {
    data: Prisma.XOR<Prisma.WordUpdateManyMutationInput, Prisma.WordUncheckedUpdateManyInput>;
    where?: Prisma.WordWhereInput;
    limit?: number;
};
export type WordUpdateManyAndReturnArgs<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs> = {
    select?: Prisma.WordSelectUpdateManyAndReturn<ExtArgs> | null;
    omit?: Prisma.WordOmit<ExtArgs> | null;
    data: Prisma.XOR<Prisma.WordUpdateManyMutationInput, Prisma.WordUncheckedUpdateManyInput>;
    where?: Prisma.WordWhereInput;
    limit?: number;
    include?: Prisma.WordIncludeUpdateManyAndReturn<ExtArgs> | null;
};
export type WordUpsertArgs<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs> = {
    select?: Prisma.WordSelect<ExtArgs> | null;
    omit?: Prisma.WordOmit<ExtArgs> | null;
    include?: Prisma.WordInclude<ExtArgs> | null;
    where: Prisma.WordWhereUniqueInput;
    create: Prisma.XOR<Prisma.WordCreateInput, Prisma.WordUncheckedCreateInput>;
    update: Prisma.XOR<Prisma.WordUpdateInput, Prisma.WordUncheckedUpdateInput>;
};
export type WordDeleteArgs<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs> = {
    select?: Prisma.WordSelect<ExtArgs> | null;
    omit?: Prisma.WordOmit<ExtArgs> | null;
    include?: Prisma.WordInclude<ExtArgs> | null;
    where: Prisma.WordWhereUniqueInput;
};
export type WordDeleteManyArgs<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs> = {
    where?: Prisma.WordWhereInput;
    limit?: number;
};
export type Word$detailArgs<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs> = {
    select?: Prisma.WordDetailSelect<ExtArgs> | null;
    omit?: Prisma.WordDetailOmit<ExtArgs> | null;
    include?: Prisma.WordDetailInclude<ExtArgs> | null;
    where?: Prisma.WordDetailWhereInput;
};
export type WordDefaultArgs<ExtArgs extends runtime.Types.Extensions.InternalArgs = runtime.Types.Extensions.DefaultArgs> = {
    select?: Prisma.WordSelect<ExtArgs> | null;
    omit?: Prisma.WordOmit<ExtArgs> | null;
    include?: Prisma.WordInclude<ExtArgs> | null;
};
export {};
